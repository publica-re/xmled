defmodule XMLed.Parsers.XML do
  import NimbleParsec

  def parse_from_file(path) do
    case File.read(path) do
      {:ok, content} -> parse_from_string(content)
      {:error, posix} -> {:error, posix}
    end
  end

  def parse_from_string(input) do
    case parse(input) do
      {:ok, doc, _, _, _, _} -> {:ok, doc}
      v -> v
    end
  end

  def check_tags(_rest, user_acc, context, _line, _offset) do
    name = Keyword.get(user_acc, :name)
    {:name, etag_name} = Keyword.get(user_acc, :etag_name)
    if name == etag_name do
      {Keyword.drop(user_acc, [:etag_name]), context}
    else
      {:error, "starting #{name} and ending #{etag_name} tag names do not match"}
    end
  end

  def prepare_entity(_rest, [name: name], context, _line, _offset) do
    {[entity_ref: name], context}
  end

  # Based off https://cs.lmu.edu/~ray/notes/xmlgrammar/

  # parsec:XMLed.Parsers.XML

  # Characters
  # Char ::= [#x1-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]
  x_Char = utf8_char([0x1..0xD7FF, 0xE000..0xFFFD, 0x10000..0x10FFFF]) |> label("Char")


  # Whitespace
  # S ::= (#x20 | #x9 | #xD | #xA)+
  x_S = times(utf8_char([0x20, 0x9, 0xD, 0xA]), min: 1) |> label("S")

  # Names and Tokens

  # NameStartChar ::= ":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]
  x_NameStartChar = utf8_char([?:, ?A..?Z, ?_, ?a..?z, 0xC0..0xD6, 0xD8..0xF6, 0xF8..0x2FF, 0x370..0x37D, 0x37F..0x1FFF, 0x200C..0x200D, 0x2070..0x218F, 0x2C00..0x2FEF, 0x3001..0xD7FF, 0xF900..0xFDCF]) |> label("first character of name")
  # NameChar ::= NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
  x_NameChar = utf8_char([?:, ?A..?Z, ?_, ?a..?z, 0xC0..0xD6, 0xD8..0xF6, 0xF8..0x2FF, 0x370..0x37D, 0x37F..0x1FFF, 0x200C..0x200D, 0x2070..0x218F, 0x2C00..0x2FEF, 0x3001..0xD7FF, 0xF900..0xFDCF, ?-, ?., ?0..?9, 0xB7, 0x300..0x36F, 0x203F..0x2040]) |> label("character of name")
  # Name ::= NameStartChar (NameChar)*
  x_Name =
    x_NameStartChar
    |> concat(times(x_NameChar, min: 0))
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:name)
    |> label("Name")
  # Nmtoken ::= (NameChar)+
  x_Nmtoken =
    times(x_NameChar, min: 1)
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:nmtoken)
    |> label("Nmtoken")

  # Literals
  # CharRef ::= '&#' [0-9]+ ';' | '&#x' [0-9a-fA-F]+ ';
  x_CharRef =
    choice([
      ignore(string("&#")) |> concat(integer(min: 1)) |> tag(:CR_integer),
      ignore(string("&#x")) |> concat(repeat(utf8_char([?0..?9, ?a..?f, ?A..?F]), utf8_char([?0..?9, ?a..?f, ?A..?F]))) |> tag(:CR_hexa),
    ])
    |> tag(:CharRef)
    |> label("CharRef")
  # EntityRef ::= '&' Name ';'
  x_EntityRef =
    ignore(string("&"))
    |> concat(x_Name)
    |> ignore(string(";"))
    |> post_traverse({:prepare_entity, []})
    |> label("EntityRef")
  # Reference ::= EntityRef | CharRef
  x_Reference =
    choice([
      x_EntityRef,
      x_CharRef
    ])
    |> label("Reference")
  # PEReference ::= '%' Name ';'
  x_PEReference =
    ignore(string("%"))
    |> concat(x_Name)
    |> ignore(string(";"))
    |> tag(:PEReference)
    |> label("PEReference")
  # EntityValue ::= '"' ([^%&"] | PEReference | Reference)* '"' |  "'" ([^%&'] | PEReference | Reference)* "'"
  x_EntityValue =
    choice([
        ignore(string("\"")) |> repeat(choice([ utf8_char([not: ?%, not: 38, not: ?"]), x_PEReference, x_Reference ])) |> ignore(string("\"")),
        ignore(string("'")) |> repeat(choice([ utf8_char([not: ?%, not: 38, not: ?']), x_PEReference, x_Reference ])) |> ignore(string("'"))
      ])
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:entity_value)
    |> label("EntityValue")
  # AttValue ::= '"' ([^<&"] | Reference)* '"' |  "'" ([^<&'] | Reference)* "'"
  x_AttValueContent =
    optional(repeat(utf8_char([not: ?<, not: 38, not: ?"]))) |> reduce({List, :to_string, []}) |> unwrap_and_tag(:text)
    |> concat(repeat(x_Reference |> concat(optional(repeat(utf8_char([not: ?<, not: 38, not: ?"]))) |> reduce({List, :to_string, []}) |> unwrap_and_tag(:text))))
  x_AttValueContentSQO =
    optional(repeat(utf8_char([not: ?<, not: 38, not: ?']))) |> reduce({List, :to_string, []}) |> unwrap_and_tag(:text)
    |> concat(repeat(x_Reference |> concat(optional(repeat(utf8_char([not: ?<, not: 38, not: ?"]))) |> reduce({List, :to_string, []}) |> unwrap_and_tag(:text))))
  x_AttValue =
    choice([
      ignore(string("\"")) |> concat(x_AttValueContent) |> ignore(string("\"")),
      ignore(string("'")) |> concat(x_AttValueContentSQO) |> ignore(string("'"))
    ])
    |> tag(:value)
    |> label("AttValue")

  # SystemLiteral ::= ('"' [^"]* '"') | ("'" [^']* "'")
  x_SystemLiteral =
    choice([
      ignore(string("\"")) |> concat(repeat(utf8_char([not: ?"]))) |> ignore(string("\"")),
      ignore(string("'")) |> concat(repeat(utf8_char([not: ?']))) |> ignore(string("'"))
    ])
    |> tag(:system_literal)
    |> label("SystemLiteral")
  # PubidChar ::= #x20 | #xD | #xA | [a-zA-Z0-9] | [-'()+,./:=?;!*#@$_%]
  x_PubidChar = utf8_char([0x0020, 0x000D, 0x000A, ?a..?z, ?A..?Z, ?0..?9, ?-, ?', ?(, ?), ?+, ?,, ?., ?/, ?:, ?=, ??, ?;, ?!, ?*, ?#, ?@, ?$, ?_, ?%]) |> label("PubidChar")
  x_PubidChar__WOQ = utf8_char([0x0020, 0x000D, 0x000A, ?a..?z, ?A..?Z, ?0..?9, ?-, ?(, ?), ?+, ?,, ?., ?/, ?:, ?=, ??, ?;, ?!, ?*, ?#, ?@, ?$, ?_, ?%]) |> label("PubidChar w/o quotes")
  # PubidLiteral ::= '"' PubidChar* '"' | "'" (PubidChar - "'")* "'"
  x_PubidLiteral =
    choice([
        ignore(string("\"")) |> repeat(x_PubidChar) |> ignore(string("\"")),
        ignore(string("'")) |> repeat(x_PubidChar__WOQ) |> ignore(string("'")),
      ])
    |> tag(:pubid_literal)
    |> label("PubidLiteral")

  # Character Data
  # CharData ::= [^<&]* - ([^<&]* ']]>' [^<&]*)
  x_CharData = repeat(utf8_char([not: ?<, not: 38]) |> lookahead_not(string("]]>"))) |> label("CharData")

  # Comments
  # Comment ::= '<!--' ((Char - '-') | ('-' (Char - '-')))* '-->'
  x_Comment =
    ignore(string("<!--"))
    |> concat(repeat(lookahead_not(string("--")) |> concat(x_Char)))
    |> ignore(string("-->"))
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:comment)
    |> label("Comment")

  # Processing Instructions
  # PITarget ::= Name - (('X' | 'x') ('M' | 'm') ('L' | 'l'))
  x_PITarget = lookahead_not(choice([string("xml "), string("XML "), string("xml?"), string("XML?")])) |> concat(x_Name) |> label("PITarget")
  # PI ::= '<?' PITarget (S (Char* - (Char* '?>' Char*)))? '?>'
  x_PI =
    ignore(string("<?"))
    |> concat(x_PITarget)
    |> concat(optional(x_S |> concat(repeat(lookahead_not(string("?>")) |> concat(x_Char))) |> reduce({List, :to_string, []}) |> unwrap_and_tag(:data)))
    |> ignore(string("?>"))
    |> tag(:PI)
    |> label("PI")
  # CDATA

  # CDStart ::= '<![CDATA['
  x_CDStart = string("<![CDATA[")
  # CData ::= (Char* - (Char* ']]>' Char*))
  x_CData =
    repeat(lookahead_not(string("]]>")) |> concat(x_Char))
    |> reduce({List, :to_string, []})
    |> label("CData")
  # CDEnd ::= ']]>'
  x_CDEnd = string("]]>")
  # CDSect ::= CDStart CData CDEnd
  x_CDSect =
    ignore(x_CDStart)
    |> concat(x_CData)
    |> ignore(x_CDEnd)
    |> tag(:CData)
    |> label("CDSect")

  # Prolog

  # Eq ::= S? '=' S?
  x_Eq = optional(x_S) |> string("=") |> optional(x_S) |> label("Eq")
  # VersionNum ::= '1.1'
  x_VersionNum = choice([string("1.0"), string("1.1")]) |> label("VersionNum")
  # VersionInfo ::= S 'version' Eq ("'" VersionNum "'" | '"' VersionNum '"')
  x_VersionInfo =
    ignore(x_S)
    |> ignore(string("version"))
    |> ignore(x_Eq)
    |> concat(choice([
        ignore(string("\"")) |> concat(x_VersionNum) |> ignore(string("\"")),
        ignore(string("'")) |> concat(x_VersionNum) |> ignore(string("'")),
        ]))
    |> unwrap_and_tag(:version)
    |> label("VersionInfo")
  # SDDecl ::= S 'standalone' Eq (("'" ('yes' | 'no') "'") | ('"' ('yes' | 'no') '"'))
  x_SDDecl =
    ignore(x_S)
    |> ignore(string("standalone"))
    |> ignore(x_Eq)
    |> concat(choice([
        ignore(string("\"")) |> choice([string("yes"), string("no")]) |> ignore(string("\"")),
        ignore(string("'")) |> choice([string("yes"), string("no")]) |> ignore(string("'"))
      ]))
    |> unwrap_and_tag(:standalone)
    |> label("SDDecl")
  # EncName ::= [A-Za-z] ([A-Za-z0-9._] | '-')*
  x_EncName = utf8_char([?A..?Z, ?a..?z]) |> concat(repeat(utf8_char([?A..?Z, ?a..?z, ?0..?9, ?., ?_, ?-]))) |> label("EncName")
  # EncodingDecl ::= S 'encoding' Eq ('"' EncName '"' | "'" EncName "'" )
  x_EncodingDecl =
    ignore(x_S)
    |> ignore(string("encoding"))
    |> ignore(x_Eq)
    |> concat(choice([
        ignore(string("\"")) |> concat(x_EncName) |> ignore(string("\"")),
        ignore(string("'")) |> concat(x_EncName) |> ignore(string("'"))
      ]))
    |> reduce({List, :to_string, []})
    |> unwrap_and_tag(:encoding)
    |> label("EncodingDecl")
  # XMLDecl ::= '<?xml' VersionInfo EncodingDecl? SDDecl? S? '?>'
  x_XMLDecl =
    ignore(string("<?xml"))
    |> concat(x_VersionInfo)
    |> concat(optional(x_EncodingDecl))
    |> concat(optional(x_SDDecl))
    |> concat(optional(x_S))
    |> ignore(string("?>"))
    |> tag(:xml_decl)
    |> label("XMLDecl")
  # Misc ::= Comment | PI | S
  x_Misc =
    choice([
      x_Comment,
      x_PI,
      x_S |> reduce({List, :to_string, []}) |> unwrap_and_tag(:text)
    ])
    |> label("Misc")

    # children ::= (choice | seq) ('?' | '*' | '+')?
    x_children =
      choice([parsec(:x_choice), parsec(:x_sep)])
      |> concat(optional(choice([string("?") |> replace(:maybe), string("*") |> replace(:some), string("+") |> replace(:many)])))
      |> tag(:children)
      |> label("children")
  #  cp ::= (Name | choice | seq) ('?' | '*' | '+')?
  x_cp =
    choice([x_Name, parsec(:x_choice), parsec(:x_sep)])
    |> concat(optional(choice([string("?") |> replace(:maybe), string("*") |> replace(:some), string("+") |> replace(:many)])))
    |> tag(:cp)
    |> label("cp")
  # choice ::= '(' S? cp ( S? '|' S? cp )+ S? ')'
  defcombinatorp :x_choice, ignore(string("("))
            |> ignore(optional(x_S))
            |> concat(x_cp)
            |> concat(repeat(ignore(optional(x_S)) |> ignore(string("|")) |> ignore(optional(x_S)) |> concat(x_cp)))
            |> ignore(optional(x_S))
            |> ignore(string(")"))
            |> tag(:choice)
            |> label("choice")
  # seq ::= '(' S? cp ( S? ',' S? cp )* S? ')'
  defcombinatorp :x_sep, ignore(string("("))
        |> ignore(optional(x_S))
        |> concat(x_cp)
        |> concat(repeat(ignore(optional(x_S)) |> ignore(string(",")) |> ignore(optional(x_S)) |> concat(x_cp)))
        |> ignore(optional(x_S))
        |> ignore(string(")"))
        |> tag(:sequence)
        |> label("seq")
  # Mixed ::= '(' S? '#PCDATA' (S? '|' S? Name)* S? ')*' | '(' S? '#PCDATA' S? ')'
  x_Mixed =
    choice([
      ignore(string("(") |> optional(x_S)) |> concat(string("#PCDATA") |> replace(:PCDATA)) |> concat(repeat(ignore(optional(x_S) |> string("|") |> optional(x_S)) |> concat(x_Name))) |> ignore(optional(x_S)) |> ignore(string(")*")),
      ignore(string("(") |> optional(x_S)) |> concat(string("#PCDATA") |> replace(:PCDATA)) |> ignore(optional(x_S) |>string(")")),
    ])
    |> tag(:mixed)
    |> label("Mixed")
  # contentspec ::= 'EMPTY' | 'ANY' | Mixed | children
  x_contentspec =
    choice([
      string("EMPTY"),
      string("ANY"),
      x_Mixed,
      x_children
    ])
    |> tag(:contentspec)
    |> label("contentspec")
  # elementdecl ::= '<!ELEMENT' S Name S contentspec S? '>'
  x_elementdecl =
    ignore(string("<!ELEMENT"))
    |> ignore(x_S)
    |> concat(x_Name)
    |> ignore(x_S)
    |> concat(x_contentspec)
    |> ignore(string(">"))
    |> tag(:element_decl)
    |> label("elementdecl")
  # StringType ::= 'CDATA'
  x_StringType = ignore(string("CDATA")) |> replace(:string) |> label("StringType")
  # TokenizedType ::= 'ID' | 'IDREF' | 'IDREFS' | 'ENTITY' | 'ENTITIES' | 'NMTOKEN' | 'NMTOKENS'
  x_TokenizedType =
    choice([
          ignore(string("ID")) |> replace(:ID),
          ignore(string("IDREF")) |> replace(:IDREF),
          ignore(string("IDREFS")) |> replace(:IDREFS),
          ignore(string("ENTITY")) |> replace(:ENTITY),
          ignore(string("ENTITIES")) |> replace(:ENTITIES),
          ignore(string("NMTOKEN")) |> replace(:NMTOKEN),
          ignore(string("NMTOKENS")) |> replace(:NMTOKENS),
        ])
    |> label("TokenizedType")
  # NotationType ::= 'NOTATION' S '(' S? Name (S? '|' S? Name)* S? ')'
  x_NotationType =
    ignore(string("NOTATION"))
      |> ignore(x_S)
      |> ignore(string("("))
      |> ignore(optional(x_S))
      |> concat(x_Name)
      |> concat(repeat(ignore(optional(x_S) |> string("|") |> optional(x_S)) |> concat(x_Name)))
      |> ignore(optional(x_S))
      |> ignore(string(")"))
      |> tag(:notation)
      |> label("NotationType")
  # Enumeration ::= '(' S? Nmtoken (S? '|' S? Nmtoken)* S? ')'
  x_Enumeration =
    ignore(string("("))
    |> ignore(optional(x_S))
    |> concat(x_Nmtoken)
    |> concat(repeat(ignore(optional(x_S)) |> ignore(string("|")) |> ignore(optional(x_S)) |> concat(x_Nmtoken)))
    |> ignore(optional(x_S))
    |> ignore(string(")"))
    |> tag(:enumeration)
    |> label("Enumeration")
  # DefaultDecl ::= '#REQUIRED' | '#IMPLIED' | (('#FIXED' S)? AttValue
  x_DefaultDecl =
    choice([
          ignore(string("#REQUIRED")) |> replace(:required),
          ignore(string("#IMPLIED")) |> replace(:implied),
          optional(ignore(string("#FIXED")) |> ignore(x_S)) |> concat(x_AttValue) |> tag(:fixed)
        ])
    |> unwrap_and_tag(:default)
    |> label("DefaultDecl")
  # EnumeratedType ::= NotationType | Enumeration
  x_EnumeratedType = choice([x_NotationType, x_Enumeration]) |> label("EnumeratedType")
  # AttType ::= StringType | TokenizedType | EnumeratedType
  x_AttType =
    choice([ x_StringType, x_TokenizedType, x_EnumeratedType ])
    |> unwrap_and_tag(:type)
    |> label("AttType")
  # AttDef ::= S Name S AttType S DefaultDecl
  x_AttDef =
    ignore(x_S)
    |> concat(x_Name)
    |> ignore(x_S)
    |> concat(x_AttType)
    |> ignore(x_S)
    |> concat(x_DefaultDecl)
    |> tag(:attribute_decl)
    |> label("AttDef")
  # AttlistDecl ::= '<!ATTLIST' S Name AttDef* S? '>'
  x_AttlistDecl =
    ignore(string("<!ATTLIST"))
    |> ignore(x_S)
    |> concat(x_Name)
    |> concat(repeat(x_AttDef))
    |> ignore(optional(x_S))
    |> ignore(string(">"))
    |> tag(:attributes_decl)
    |> label("AttlistDecl")
  # ExternalID ::= 'SYSTEM' S SystemLiteral  | 'PUBLIC' S PubidLiteral S SystemLiteral
  x_ExternalID =
    choice([
        ignore(string("SYSTEM")) |> ignore(x_S) |> concat(x_SystemLiteral) |> tag(:system),
        ignore(string("PUBLIC")) |> ignore(x_S) |> concat(x_PubidLiteral) |> ignore(x_S) |> concat(x_SystemLiteral) |> tag(:public),
      ])
    |> label("ExternalID")
  # NDataDecl ::= S 'NDATA' S Name
  x_NDataDecl =
    ignore(x_S)
    |> ignore(string("NDATA"))
    |> ignore(x_S)
    |> concat(x_Name)
    |> tag(:NDataDecl)
    |> label("NDataDecl")
  # EntityDef ::= EntityValue | (ExternalID NDataDecl?)
  x_EntityDef =
    choice([x_EntityValue, x_ExternalID |> concat(optional(x_NDataDecl))])
    |> label("EntityDef")
  # GEDecl ::= '<!ENTITY' S Name S EntityDef S? '>'
  x_GEDecl =
    ignore(string("<!ENTITY"))
    |> ignore(x_S)
    |> concat(x_Name)
    |> ignore(x_S)
    |> concat(x_EntityDef)
    |> ignore(optional(x_S))
    |> ignore(string(">"))
    |> tag(:entity_decl)
    |> label("GEDecl")
  # PEDef ::= EntityValue | ExternalID
  x_PEDef =
    choice([x_EntityValue, x_ExternalID])
    |> tag(:PEDef)
    |> label("PEDef")
  # PEDecl ::= '<!ENTITY' S '%' S Name S PEDef S? '>'
  x_PEDecl =
    ignore(string("<!ENTITY"))
    |> ignore(x_S)
    |> ignore(string("%"))
    |> ignore(x_S)
    |> concat(x_Name)
    |> ignore(x_S)
    |> concat(x_PEDef)
    |> ignore(optional(x_S))
    |> ignore(string(">"))
    |> tag(:parameter_entity_decl)
    |> label("PEDecl")
  # EntityDecl ::= GEDecl | PEDecl
  x_EntityDecl =
    choice([x_GEDecl, x_PEDecl])
    |> label("EntityDecl")
  # PublicID ::= 'PUBLIC' S PubidLiteral
  x_PublicID =
    ignore(string("PUBLIC"))
      |> ignore(x_S)
      |> concat(x_PubidLiteral)
      |> tag(:PublicID)
      |> label("PublicID")
  # NotationDecl ::= '<!NOTATION' S Name S (ExternalID | PublicID) S? '>'
  x_NotationDecl =
    ignore(string("<!NOTATION"))
    |> ignore(x_S)
    |> concat(x_Name)
    |> ignore(x_S)
    |> concat(choice([x_ExternalID, x_PublicID]))
    |> ignore(optional(x_S))
    |> ignore(string(">"))
    |> tag(:notation_decl)
    |> label("NotationDecl")
  # markupdecl ::= elementdecl | AttlistDecl | EntityDecl | NotationDecl | PI | Comment
  x_markupdecl =
    choice([
      x_elementdecl,
      x_AttlistDecl,
      x_EntityDecl,
      x_NotationDecl,
      x_PI,
      x_Comment
    ])
    |> label("markupdecl")
  # DeclSep ::= PEReference | S
  x_DeclSep = choice([x_PEReference, ignore(x_S)]) |> label("DeclSep")
  # ignoreSect ::= '<![' S? 'IGNORE' S? '[' ignoreSectContents* ']]>'
  x_ignoreSect =
    ignore(string("<!["))
    |> ignore(optional(x_S))
    |> ignore(string("IGNORE"))
    |> ignore(optional(x_S))
    |> ignore(string("["))
    |> concat(repeat(parsec(:x_ignoreSectContents)))
    |> ignore(string("]]>"))
    |> tag(:ignoreSect)
    |> label("ignoreSect")
  #	conditionalSect ::= includeSect | ignoreSect
  x_conditionalSect = choice([parsec(:x_includeSect), x_ignoreSect]) |> tag(:conditionalSect) |> label("conditionalSect")
  # intSubset ::= (markupdecl | DeclSep)*
  x_intSubset =
    repeat(choice([
      x_markupdecl,
      x_conditionalSect,
      x_DeclSep
    ]))
    |> label("intSubset")
  # doctypedecl ::= '<!DOCTYPE' S Name (S ExternalID)? S? ('[' intSubset ']' S?)? '>'
  x_doctypedecl =
    ignore(string("<!DOCTYPE"))
    |> ignore(x_S)
    |> concat(x_Name)
    |> concat(optional(ignore(x_S) |> concat(x_ExternalID)))
    |> ignore(optional(x_S))
    |> concat(optional(ignore(string("[")) |> concat(x_intSubset) |> ignore(string("]") |> optional(x_S))))
    |> ignore(string(">"))
    |> tag(:doctype_decl)
    |> label("doctypedecl")
  # prolog ::= XMLDecl Misc* (doctypedecl Misc*)?
  x_prolog =
    x_XMLDecl
    |> concat(repeat(x_Misc))
    |> concat(optional(x_doctypedecl |> concat(repeat(x_Misc))))
    |> tag(:prolog)
    |> label("prolog")

  # Document type definition
  # extSubsetDecl ::= ( markupdecl | conditionalSect | DeclSep)*
  x_extSubsetDecl = repeat(choice([x_markupdecl, x_conditionalSect, x_DeclSep])) |> label("extSubsetDecl")
  # UNUSED: extSubset ::= TextDecl? extSubsetDecl
  # UNUSED: x_extSubset = optional(x_TextDecl) |> concat(x_extSubsetDecl) |> label("extSubset")

  # Standalone Document Declaration
  # Attribute ::= Name Eq AttValue
  x_Attribute =
    x_Name
    |> ignore(x_Eq)
    |> concat(x_AttValue)
    |> tag(:attribute)
    |> label("Attribute")
  # STag ::= '<' Name (S Attribute)* S? '>'
  x_STag =
    ignore(string("<"))
    |> concat(x_Name)
    |> concat(repeat(ignore(x_S) |> concat(x_Attribute)))
    |> ignore(optional(x_S))
    |> ignore(string(">"))
    |> label("STag")
  # ETag ::= '</' Name S? '>'
  x_ETag =
    ignore(string("</"))
    |> concat(x_Name)
    |> ignore(optional(x_S))
    |> ignore(string(">"))
    |> unwrap_and_tag(:etag_name)
    |> label("ETag")
  # EmptyElemTag ::= '<' Name (S Attribute)* S? '/>'
  x_EmptyElemTag =
    ignore(string("<"))
    |> concat(x_Name)
    |> concat(repeat(ignore(x_S) |> concat(x_Attribute)))
    |> ignore(optional(x_S))
    |> ignore(string("/>"))
    |> label("EmptyElemenTag")
  # content ::= CharData? ((element | Reference | CDSect | PI | Comment) CharData?)*
  x_content =
    (optional(x_CharData |> reduce({List, :to_string, []}) |> unwrap_and_tag(:text)))
    |> concat(
        repeat(choice([
          x_Reference,
          x_CDSect,
          x_PI,
          x_Comment,
          parsec(:x_element)])
        |> concat(optional(x_CharData) |> reduce({List, :to_string, []}) |> unwrap_and_tag(:text))))
    |> tag(:content)
    |> label("content")
  # element ::= EmptyElemTag | STag content ETag
  defcombinatorp :x_element,
    choice([
      x_EmptyElemTag,
      x_STag
      |> concat(x_content)
      |> concat(x_ETag)
    ])
    |> post_traverse({:check_tags, []})
    |> tag(:element)
    |> label("element")

  # Elements in the DTD

  # Attributes in the DTD

  # Conditional Section
  # includeSect ::= '<![' S? 'INCLUDE' S? '[' extSubsetDecl ']]>'
  defcombinatorp :x_includeSect, ignore(string("<!["))
                |> ignore(optional(x_S))
                |> ignore(string("INCLUDE"))
                |> ignore(optional(x_S))
                |> ignore(string("["))
                |> concat(repeat(x_extSubsetDecl))
                |> ignore(string("]]>"))
                |> tag(:includeSect)
                |> label("includeSect")
  # Ignore ::= Char* - (Char* ('<![' | ']]>') Char*)
  x_Ignore =
    repeat(lookahead_not(choice([string("<!["), string("]]>")])) |> concat(x_Char))
    |> tag(:Ignore)
    |> label("Ignore")
  # ignoreSectContents ::= Ignore ('<![' ignoreSectContents ']]>' Ignore)*
  defcombinatorp :x_ignoreSectContents,
                          x_Ignore
                        |> concat(repeat(ignore(string("<![")) |> concat(parsec(:x_ignoreSectContents)) |> ignore(string("]]>")) |> concat(x_Ignore)))
                        |> tag(:ignoreSectContents)
                        |> label("ignoreSectContents")

  # Character and Entity References

  # Entity Declarations

  # Parsed entities
  # UNUSED: TextDecl ::= '<?xml' VersionInfo? EncodingDecl S? '?>'
  # UNUSED: x_TextDecl = ignore(string("<?xml")) |> concat(optional(x_VersionInfo)) |> concat(x_EncodingDecl) |> concat(optional(x_S)) |> ignore(string("?>")) |> tag(:TextDecl) |> label("TextDecl")
  # UNUSED: extParsedEnt ::= ( TextDecl? content ) - ( Char* RestrictedChar Char* )
  # UNUSED: x_extParsedEnt = optional(x_TextDecl) |> concat(x_content) |> tag(:extParsedEnt) |> label("extParsedEnt")

  # document ::= ( prolog element Misc* ) - ( Char* RestrictedChar Char* )
  x_document =
    x_prolog
    |> concat(parsec(:x_element))
    |> concat(repeat(x_Misc))
    |> tag(:document)
    |> label("document")

  # Parser
  defparsecp :parse, x_document

  # parsec:XMLed.Parsers.XML

end
