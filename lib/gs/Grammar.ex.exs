defmodule Mod do
  def chars_to_list(a), do: a |> Enum.map(fn x -> {c, _} = Integer.parse(x, 16); c end)
  def char_range_to_list(a, b) do
    {aC, _} = Integer.parse(a, 16)
    {bC, _} = Integer.parse(b, 16)
    aC..bC
  end
end

defmodule GS.Grammar do
  import NimbleParsec

  def parse_from_file(path) do
    case File.read(path) do
      {:ok, content} -> parse_from_string(content)
      {:error, posix} -> {:error, posix}
    end
  end

  def parse_from_string(input) do
    parse(input)
  end

  # Based off https://cs.lmu.edu/~ray/notes/xmlgrammar/

  # Characters
  # Char ::= [#x1-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]
  @valid_Char Enum.concat([ Mod.chars_to_list(["9", "A", "D"]), Mod.char_range_to_list("20", "D7FF"), Mod.char_range_to_list("E000", "FFFD"), Mod.char_range_to_list("10000", "10FFFF") ])
  defcombinatorp :x_Char, utf8_char(@valid_Char)
         |> label("Char")


  # Whitespace
  # S ::= (#x20 | #x9 | #xD | #xA)+
  @valid_S Mod.chars_to_list(["20", "9", "D", "A"])
  defcombinatorp :x_S, times(utf8_char(@valid_S), min: 1)
      |> label("S")

  # Names and Tokens

  # NameStartChar ::= ":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]
  @valid_NameStartChar Enum.concat([[":", "_"], Mod.char_range_to_list("41", "7A"), Mod.char_range_to_list("C0", "D6"), Mod.char_range_to_list("D8", "F6"), Mod.char_range_to_list("F8", "2FF"), Mod.char_range_to_list("370", "37D"), Mod.char_range_to_list("37F", "1FFF"), Mod.char_range_to_list("200C", "200D"), Mod.char_range_to_list("2070", "218F"), Mod.char_range_to_list("2C00", "2FEF"), Mod.char_range_to_list("3001", "D7FF"), Mod.char_range_to_list("F900", "FDCF"), Mod.char_range_to_list("FDF0", "FFFD"), Mod.char_range_to_list("10000", "EFFFF")])
  defcombinatorp :x_NameStartChar, utf8_char(@valid_NameStartChar)
                  |> label("NameStartChar")
  # NameChar ::= NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
  @valid_NameChar Enum.concat([@valid_NameStartChar, Mod.chars_to_list(["2D", "2E", "B7"]), Mod.char_range_to_list("30", "39"), Mod.char_range_to_list("0300", "036F"), Mod.char_range_to_list("203F", "2040")])
  defcombinatorp :x_NameChar, utf8_char(@valid_NameChar)
             |> label("NameChar")
  # Name ::= NameStartChar (NameChar)*
  defcombinatorp :x_Name, parsec(:x_NameStartChar)
         |> concat(times(parsec(:x_NameChar), min: 0))
         |> tag(:name)
         |> label("Name")
  # Names ::= Name (#x20 Name)
  defcombinatorp :x_Names, times(parsec(:x_Name) |> lookahead(choice([string(" "), eos()])), min: 1)
          |> label("Names")
  # Nmtoken ::= (NameChar)+
  defcombinatorp :x_Nmtoken, times(parsec(:x_NameChar), min: 1)
            |> tag(:nmtoken)
            |> label("Nmtoken")
  # Nmtokens ::= Nmtoken (#x20 Nmtoken)*
  defcombinatorp :x_Nmtokens, times(parsec(:x_Nmtoken) |> lookahead(choice([string(" "), eos()])), min: 1)
            |> label("Names")

  # Literals
  # EntityValue ::= '"' ([^%&"] | PEReference | Reference)* '"' |  "'" ([^%&'] | PEReference | Reference)* "'"
  defcombinatorp :x_EntityValue, choice([ 
                    ignore(string("\"")) |> repeat(choice([ utf8_char({:not, [?%, ?&, ?"]}), parsec(:x_PEReference), parsec(:x_Reference) ])) |> ignore(string("\"")),
                    ignore(string("'")) |> repeat(choice([ utf8_char({:not, [?%, ?&, ?']}), parsec(:x_PEReference), parsec(:x_Reference) ])) |> ignore(string("'"))
                  ])
                |> tag(:entity_value)
                |> label("EntityValue")
  # AttValue ::= '"' ([^<&"] | Reference)* '"' |  "'" ([^<&'] | Reference)* "'"
  defcombinatorp :x_AttValue, choice([ 
                ignore(string("\"")) |> repeat(choice([ utf8_char({:not, [?<, ?"]}), parsec(:x_Reference) ])) |> ignore(string("\"")),
                ignore(string("'")) |> repeat(choice([ utf8_char({:not, [?<, ?']}), parsec(:x_Reference) ])) |> ignore(string("'"))
              ])
             |> tag(:att_value)
             |> label("AttValue")
  # SystemLiteral ::= ('"' [^"]* '"') | ("'" [^']* "'") 
  defcombinatorp :x_SystemLiteral, choice([ 
                      ignore(string("\"")) |> repeat(choice([ utf8_char({:not, [?"]}) ])) |> ignore(string("\"")),
                      ignore(string("'")) |> repeat(choice([ utf8_char({:not, [?']}) ])) |> ignore(string("'"))
                    ])
                  |> tag(:system_literal)
                  |> label("SystemLiteral")
  # PubidLiteral ::= '"' PubidChar* '"' | "'" (PubidChar - "'")* "'"
  defcombinatorp :x_PubidLiteral, choice([
                      ignore(string("\"")) |> repeat(parsec(:x_PubidChar)) |> ignore(string("\"")),
                      ignore(string("'")) |> repeat(parsec(:x_PubidChar__WOQ)) |> ignore(string("'")),
                   ])
                 |> tag(:pubid_literal)
                 |> label("PubidLiteral")
  # PubidChar ::= #x20 | #xD | #xA | [a-zA-Z0-9] | [-'()+,./:=?;!*#@$_%]
  @valid_PubidChar Enum.concat([Mod.chars_to_list(["20", "D", "A"]), Mod.char_range_to_list("41", "5A"), Mod.char_range_to_list("61", "7A"), String.graphemes("-'()+,./:=?;!*#@$_%")])
  defcombinatorp :x_PubidChar, utf8_char(@valid_PubidChar)
              |> label("PubidChar")
  @valid_PubidChar__WOQ Enum.concat([Mod.chars_to_list(["20", "D", "A"]), Mod.char_range_to_list("41", "5A"), Mod.char_range_to_list("61", "7A"), String.graphemes("-()+,./:=?;!*#@$_%")])
  defcombinatorp :x_PubidChar__WOQ, utf8_char(@valid_PubidChar__WOQ)
              |> label("PubidChar w/o quotes")

  # Character Data
  # CharData ::= [^<&]* - ([^<&]* ']]>' [^<&]*)
  defcombinatorp :x_CharData, repeat(lookahead_not(string("]]>") |> choice(utf8_char({:not, [?<, ?&]}))))
             |> label("CharData")

  # Comments
  # Comment ::= '<!--' ((Char - '-') | ('-' (Char - '-')))* '-->'
  defcombinatorp :x_Comment, ignore(string("<!--")) 
            |> concat(repeat(lookahead_not(string("--") |> parsec(:x_Char))))
            |> ignore(string("-->"))
            |> tag(:comment)
            |> label("Comment")

  # Processing Instructions
  # PI ::= '<?' PITarget (S (Char* - (Char* '?>' Char*)))? '?>'
  defcombinatorp :x_PI, ignore(string("<?")) 
       |> concat(parsec(:x_PITarget))
       |> concat(optional(parsec(:x_S) |> concat(repeat(lookahead_not(string("?>") |> parsec(:x_Char))))))
       |> ignore(string("?>"))
       |> tag(:PI)
       |> label("PI")
  # PITarget ::= Name - (('X' | 'x') ('M' | 'm') ('L' | 'l'))
  defcombinatorp :x_PITarget, lookahead_not(choice([string("xml"), string("XML")])) |> parsec(:x_Name)

  # CDATA

  # CDSect ::= CDStart CData CDEnd 
  defcombinatorp :x_CDSect, ignore(parsec(:x_CDStart))
          |> concat(parsec(:x_CDData))
          |> ignore(parsec(:x_CDEnd))
          |> tag(:CDSect)
          |> label("CDSect")
  # CDStart ::= '<![CDATA['
  defcombinatorp :x_CDStart, string("<![CDATA[")
  # CData ::= (Char* - (Char* ']]>' Char*))
  defcombinatorp :x_CData, repeat(lookahead_not(string("]]>")) |> parsec(:x_Char))
          |> label("CData")
  # CDEnd ::= ']]>'
  defcombinatorp :x_CDEnd, string("]]>")

  # Prolog

  # prolog ::= XMLDecl Misc* (doctypedecl Misc*)?
  defcombinatorp :x_prolog, parsec(:x_XMLDecl)
           |> concat(repeat(parsec(:x_Misc)))
           |> concat(optional(parsec(:x_doctypedecl) |> concat(repeat(parsec(:x_Misc)))))
           |> tag(:prolog)
           |> label("prolog")
  # XMLDecl ::= '<?xml' VersionInfo EncodingDecl? SDDecl? S? '?>'
  defcombinatorp :x_XMLDecl, ignore(string("<?xml"))
            |> concat(parsec(:x_VersionInfo))
            |> concat(optional(parsec(:x_SDDecl)))
            |> concat(optional(parsec(:x_S)))
            |> ignore(string("?>"))
            |> tag(:XMLDecl)
            |> label("XMLDecl")
  # VersionInfo ::= S 'version' Eq ("'" VersionNum "'" | '"' VersionNum '"')
  defcombinatorp :x_VersionInfo, ignore(parsec(:x_S))
                |> ignore(string("version"))
                |> ignore(parsec(:x_Eq))
                |> concat(choice([
                    ignore(string("\"")) |> parsec(:x_VersionNum) |> ignore(string("\"")),
                    ignore(string("'")) |> parsec(:x_VersionNum) |> ignore(string("'")),
                   ]))
                |> tag(:versioninfo)
                |> label("VersionInfo")
  # Eq ::= S? '=' S?
  defcombinatorp :x_Eq, optional(parsec(:x_S))
       |> string("=")
       |> optional(parsec(:x_S))
       |> label("Eq")
  # VersionNum ::= '1.1'
  defcombinatorp :x_VersionNum, choice([string("1.0"), string("1.1")])
               |> label("VersionNum")
  # Misc ::= Comment | PI | S 
  defcombinatorp :x_Misc, choice([parsec(:x_Comment), parsec(:x_PI), parsec(:x_S)])
         |> label("Misc")

  # Document type definition

  # doctypedecl ::= '<!DOCTYPE' S Name (S ExternalID)? S? ('[' intSubset ']' S?)? '>'
  defcombinatorp :x_doctypedecl, ignore(string("<!DOCTYPE"))
                |> ignore(parsec(:x_S))
                |> concat(parsec(:x_Name))
                |> concat(optional(ignore(parsec(:x_S)) |> parsec(:x_ExternalID)))
                |> ignore(optional(parsec(:x_S)))
                |> concat(optional(ignore(string("[")) |> parsec(:x_intSubset) |> ignore(string("]") |> optional(parsec(:x_S)))))
                |> ignore(string(">"))
                |> tag(:doctypedecl)
                |> label("doctypedecl")
  # DeclSep ::= PEReference | S 
  defcombinatorp :x_DeclSep, choice([parsec(:x_PEReference), parsec(:x_S)])
            |> label("DeclSep")
  # intSubset ::= (markupdecl | DeclSep)*
  defcombinatorp :x_intSubset, repeat(choice([parsec(:x_markup), parsec(:x_DeclSep)]))
              |> label("intSubset")
  # markupdecl ::= elementdecl | AttlistDecl | EntityDecl | NotationDecl | PI | Comment 
  defcombinatorp :x_markupdecl, choice([parsec(:x_elementdecl), parsec(:x_AttlistDecl), parsec(:x_EntityDecl), parsec(:x_NotationDecl), parsec(:x_PI), parsec(:x_Comment)])
               |> label("markupdecl")
  # extSubset ::= TextDecl? extSubsetDecl 
  defcombinatorp :x_extSubset, optional(parsec(:x_TextDecl)) 
              |> concat(parsec(:x_extSubsetDecl))
              |> label("extSubset")
  # extSubsetDecl ::= ( markupdecl | conditionalSect | DeclSep)*
  defcombinatorp :x_extSubsetDecl, repeat(choice([parsec(:x_markupdecl), parsec(:x_conditionalSect), parsec(:x_DeclSep)]))
                  |> label("extSubsetDecl")

  # Standalone Document Declaration
  # SDDecl ::= S 'standalone' Eq (("'" ('yes' | 'no') "'") | ('"' ('yes' | 'no') '"'))
  defcombinatorp :x_SDDecl, ignore(parsec(:x_S))
           |> ignore(string("standalone"))
           |> ignore(parsec(:x_Eq))
           |> concat(choice([
                ignore(string("\"")) |> choice([string("yes"), string("no")]) |> ignore(string("\"")),
                ignore(string("'")) |> choice([string("yes"), string("no")]) |> ignore(string("'")) 
              ]))
           |> tag(:SDDecl)
           |> label("SDDecl")
  # element ::= EmptyElemTag | STag content ETag 
  defcombinatorp :x_element, choice([parsec(:x_EmptyElemTag), parsec(:x_STag) |> concat(parsec(:x_content)) |> ignore(parsec(:x_ETag))])
            |> tag(:element)
            |> label("element")
  # STag ::= '<' Name (S Attribute)* S? '>'
  defcombinatorp :x_STag, ignore(string("<"))
         |> concat(parsec(:x_Name))
         |> concat(repeat(ignore(parsec(:x_S)) |> parsec(:x_Attribute)))
         |> ignore(optional(parsec(:x_S)))
         |> ignore(string(">"))
         |> tag(:STag)
         |> label("STag")
  # Attribute ::= Name Eq AttValue 
  defcombinatorp :x_Attribute, parsec(:x_Name)
              |> ignore(parsec(:x_Eq))
              |> concat(parsec(:x_AttValue))
              |> tag(:attribute)
              |> label("Attribute")
  # ETag ::= '</' Name S? '>'
  defcombinatorp :x_ETag, ignore(string("</"))
         |> concat(parsec(:x_Name))
         |> ignore(optional(parsec(:x_S)))
         |> ignore(string(">"))
         |> tag(:ETag)
         |> label("ETag")
  # content ::= CharData? ((element | Reference | CDSect | PI | Comment) CharData?)*
  defcombinatorp :x_content, optional(parsec(:x_CharData))
            |> concat(repeat(choice([parsec(:x_element), parsec(:x_Reference), parsec(:x_CDSect), parsec(:x_PI), parsec(:x_Comment)]) |> concat(optional(parsec(:x_CharData)))))
            |> tag(:content)
            |> label("content")
  # EmptyElemTag ::= '<' Name (S Attribute)* S? '/>'
  defcombinatorp :x_EmptyElemTag, ignore(string("<"))
                |> concat(parsec(:x_Name))
                |> concat(repeat(ignore(parsec(:x_S)) |> parsec(:x_Attribute)))
                |> ignore(optional(parsec(:x_S)))
                |> ignore(string("/>"))
                |> tag(:EmptyElemTag)
                |> label("EmptyElemenTag")
                
  # Elements in the DTD
  # elementdecl ::= '<!ELEMENT' S Name S contentspec S? '>'	
  defcombinatorp :x_elementdecl, ignore(string("<!ELEMENT"))
                |> ignore(parsec(:x_S))
                |> concat(parsec(:x_Name))
                |> ignore(parsec(:x_S))
                |> concat(parsec(:x_contentspec))
                |> ignore(string(">"))
                |> tag(:elementdecl)
                |> label("elementdecl")
  # contentspec ::= 'EMPTY' | 'ANY' | Mixed | children 
  defcombinatorp :x_contentspec, choice([string("EMPTY"), string("ANY"), parsec(:x_Mixed), parsec(:x_children)])
                |> tag(:contentspec)
                |> label("contentspec")
                
  # children ::= (choice | seq) ('?' | '*' | '+')?
  defcombinatorp :x_children, choice([parsec(:x_choice), parsec(:x_sep)])
            |> concat(optional(choice([string("?"), string("*"), string("+")])))
            |> tag(:children)
            |> label("children")
  #  cp ::= (Name | choice | seq) ('?' | '*' | '+')?
  defcombinatorp :x_cp,
                choice([parsec(:x_Name), parsec(:x_choice), parsec(:x_sep)])
                |> concat(optional(choice([string("?"), string("*"), string("+")])))
                |> tag(:cp)
                |> label("cp")
  # choice ::= '(' S? cp ( S? '|' S? cp )+ S? ')'
  defcombinatorp :x_choice, ignore(string("("))
           |> ignore(optional(parsec(:x_S)))
           |> concat(parsec(:x_cp))
           |> concat(times(ignore(optional(parsec(:x_S))) |> ignore(string("|")) |> ignore(optional(parsec(:x_S))) |> concat(parsec(:x_cp)), min: 1))
           |> ignore(optional(parsec(:x_S)))
           |> ignore(string(")"))
           |> tag(:choice)
           |> label("choice")
  # seq ::= '(' S? cp ( S? ',' S? cp )* S? ')'
  defcombinatorp :x_seq, ignore(string("("))
        |> ignore(optional(parsec(:x_S)))
        |> concat(parsec(:x_cp))
        |> concat(times(ignore(optional(parsec(:x_S))) |> ignore(string(",")) |> ignore(optional(parsec(:x_S))) |> concat(parsec(:x_cp)), min: 1))
        |> ignore(optional(parsec(:x_S)))
        |> ignore(string(")"))
        |> tag(:seq)
        |> label("seq")
  
  # Mixed ::= '(' S? '#PCDATA' (S? '|' S? Name)* S? ')*' | '(' S? '#PCDATA' S? ')'
  defcombinatorp :x_Mixed, choice([
               ignore(string("(")) |> ignore(optional(parsec(:x_S))) |> ignore(string("#PCDATA")) |> concat(repeat(ignore(optional(parsec(:x_S))) |> ignore(string("|") |> ignore(optional(parsec(:x_S))) |> concat(parsec(:x_Name))))) |> ignore(optional(parsec(:x_S))) |> ignore(string(")*")),
               ignore(string("(")) |> ignore(optional(parsec(:x_S))) |> ignore(string("#PCDATA")) |> ignore(optional(parsec(:x_S))) |> ignore(string(")*")),
             ])
          |> tag(:Mixed)
          |> label("Mixed")

  # Attributes in the DTD
  # AttlistDecl ::= '<!ATTLIST' S Name AttDef* S? '>'
  defcombinatorp :x_AttlistDecl, ignore(string("<!ATTLIST"))
                |> ignore(parsec(:x_S))
                |> concat(parsec(:x_Name))
                |> concat(repeat(parsec(:x_AttDef)))
                |> ignore(optional(parsec(:x_S)))
                |> ignore(string(">"))
                |> tag(:AttlistDecl)
                |> label("AttlistDecl")
  # AttDef ::= S Name S AttType S DefaultDecl
  defcombinatorp :x_AttDef, ignore(parsec(:x_S))
           |> concat(parsec(:x_Name))
           |> ignore(parsec(:x_S))
           |> concat(parsec(:x_AttType))
           |> ignore(parsec(:x_S))
           |> concat(parsec(:x_DefaultDecl))
           |> tag(:AttDef)
           |> label("AttDef")
  # AttType ::= StringType | TokenizedType | EnumeratedType 
  defcombinatorp :x_AttType, choice([ parsec(:x_StringType), parsec(:x_TokenizedType), parsec(:x_EnumeratedType) ])
            |> tag(:AttType)
            |> label("AttType")
  # StringType ::= 'CDATA'
  defcombinatorp :x_StringType, ignore(string("CDATA"))
               |> tag(:StringType)
               |> label("StringType")
  # TokenizedType ::= 'ID' | 'IDREF' | 'IDREFS' | 'ENTITY' | 'ENTITIES' | 'NMTOKEN' | 'NMTOKENS'
  defcombinatorp :x_TokenizedType, choice([
                        ignore(string("ID")) |> tag(:ID),
                        ignore(string("IDREF")) |> tag(:IDREF),
                        ignore(string("IDREFS")) |> tag(:IDREFS),
                        ignore(string("ENTITY")) |> tag(:ENTITY),
                        ignore(string("ENTITIES")) |> tag(:ENTITIES),
                        ignore(string("NMTOKEN")) |> tag(:NMTOKEN),
                        ignore(string("NMTOKENS")) |> tag(:NMTOKENS),
                     ])
                  |> tag(:TokenizedType)
                  |> label("TokenizedType")
  # EnumeratedType ::= NotationType | Enumeration 
  defcombinatorp :x_EnumeratedType, choice([parsec(:x_NotationType), parsec(:x_Enumeration)])
                   |> tag(:EnumeratedType)
                   |> label("EnumeratedType")
  # NotationType ::= 'NOTATION' S '(' S? Name (S? '|' S? Name)* S? ')'
  defcombinatorp :x_NotatioNType, ignore(string("NOTATION"))
                 |> ignore(parsec(:x_S))
                 |> ignore(string("("))
                 |> ignore(optional(parsec(:x_S)))
                 |> concat(parsec(:x_Name))
                 |> concat(repeat(ignore(optional(parsec(:x_S))) |> ignore(string("|")) |> ignore(optional(parsec(:x_S))) |> concat(parsec(:x_Name))))
                 |> ignore(optional(parsec(:x_S)))
                 |> ignore(string("|"))
                 |> tag(:NotationType)
                 |> label("NotationType")

  # Enumeration ::= '(' S? Nmtoken (S? '|' S? Nmtoken)* S? ')'
  defcombinatorp :x_Enumeration, ignore(string("("))
                |> ignore(optional(parsec(:x_S)))
                |> concat(parsec(:x_Nmtoken))
                |> concat(repeat(ignore(optional(parsec(:x_S))) |> ignore(string("|")) |> ignore(optional(parsec(:x_S))) |> concat(parsec(:x_Nmtoken))))
                |> ignore(optional(parsec(:x_S)))
                |> ignore(string(")"))
                |> tag(:Enumeration)
                |> label("Enumeration")
  # DefaultDecl ::= '#REQUIRED' | '#IMPLIED' | (('#FIXED' S)? AttValue
  defcombinatorp :x_DefaultDecl, choice([
                     ignore(string("#REQUIRED")) |> tag(:required),
                     ignore(string("#IMPLIED")) |> tag(:implied),
                     optional(ignore(string("#FIXED") |> parsec(:x_S))) |> concat(parsec(:x_AttValue)) |> tag(:fixed)
                   ])
                |> tag(:DefaultDecl)
                |> label("DefaultDecl")

  # Conditional Section
  #	conditionalSect ::= includeSect | ignoreSect 
  defcombinatorp :x_conditionalSect, choice([parsec(:x_includeSect), parsec(:x_ignoreSect)])
                    |> tag(:conditionalSect)
                    |> label("conditionalSect")
  # includeSect ::= '<![' S? 'INCLUDE' S? '[' extSubsetDecl ']]>' 
  defcombinatorp :x_includeSect, ignore(string("<!["))
                |> ignore(optional(parsec(:x_S)))
                |> ignore(string("INCLUDE"))
                |> ignore(optional(parsec(:x_S)))
                |> ignore(string("["))
                |> concat(repeat(parsec(:x_extSubsetDecl)))
                |> ignore(string("]]>"))
                |> tag(:includeSect)
                |> label("includeSect")
  # ignoreSect ::= '<![' S? 'IGNORE' S? '[' ignoreSectContents* ']]>'
  defcombinatorp :x_ignoreSect, ignore(string("<!["))
               |> ignore(optional(parsec(:x_S)))
               |> ignore(string("IGNORE"))
               |> ignore(optional(parsec(:x_S)))
               |> ignore(string("["))
               |> concat(repeat(parsec(:x_ignoreSectContents)))
               |> ignore(string("]]>"))
               |> tag(:ignoreSect)
               |> label("ignoreSect")
  # ignoreSectContents ::= Ignore ('<![' ignoreSectContents ']]>' Ignore)*
  defcombinatorp :x_ignoreSectContents, 
                          parsec(:x_Ignore)
                       |> concat(repeat(ignore(string("<![")) |> concat(parsec(:x_ignoreSectContents)) |> ignore(string("]]>")) |> concat(parsec(:x_Ignore))))
                       |> tag(:ignoreSectContents)
                       |> label("ignoreSectContents")
  # Ignore ::= Char* - (Char* ('<![' | ']]>') Char*)
  defcombinatorp :x_Ignore, repeat(lookahead_not(choice([string("<!["), string("]]>")])) |> parsec(:x_Char))
           |> tag(:Ignore)
           |> label("Ignore")

  # Character and Entity References
  # CharRef ::= '&#' [0-9]+ ';' | '&#x' [0-9a-fA-F]+ ';
  defcombinatorp :x_CharRef, choice([
                ignore(string("&#")) |> concat(integer(min: 1)) |> tag(:CR_integer),
                ignore(string("&#x")) |> concat(repeat(choice([integer(1), utf8_char([?a..?f]), utf8_char([?A..?F])]))) |> tag(:CR_hexa), 
               ])
            |> tag(:CharRef)
            |> label("CharRef")
  defcombinatorp :x_Reference, choice([parsec(:x_EntityRef), parsec(:x_CharRef)])
              |> tag(:Reference)
              |> label("Reference")
  # EntityRef ::= '&' Name ';'
  defcombinatorp :x_EntityRef, ignore(string("&"))
             |> concat(parsec(:x_Name))
             |> ignore(string(";"))
             |> tag(:EntityRef)
             |> label("EntityRef")
  # PEReference ::= '%' Name ';'
  defcombinatorp :x_PEReference, ignore(string("%"))
                |> concat(parsec(:x_Name))
                |> ignore(string(";"))
                |> tag(:PEReference)
                |> label("PEReference")

  # Entity Declarations
  # EntityDecl ::= GEDecl | PEDecl 
  defcombinatorp :x_EntityDecl, choice([parsec(:x_GEDecl), parsec(:x_PEDecl)])
               |> tag(:EntityDecl)
               |> label("EntityDecl")
  # GEDecl ::= '<!ENTITY' S Name S EntityDef S? '>'
  defcombinatorp :x_GEDecl, ignore(string("<!ENTITY"))
           |> ignore(parsec(:x_S))
           |> concat(parsec(:x_Name))
           |> concat(parsec(:x_EntityDef))
           |> ignore(optional(parsec(:x_S)))
           |> ignore(string(">"))
           |> tag(:GEDecl)
           |> label("GEDecl")
  # PEDecl ::= '<!ENTITY' S '%' S Name S PEDef S? '>'
  defcombinatorp :x_PEDecl, ignore(string("<!ENTITY"))
           |> ignore(parsec(:x_S))
           |> ignore(string("%"))
           |> ignore(parsec(:x_S))
           |> concat(parsec(:x_Name))
           |> concat(parsec(:x_PEDef))
           |> ignore(optional(parsec(:x_S)))
           |> ignore(string(">"))
           |> tag(:PEDecl)
           |> label("PEDecl")
  # EntityDef ::= EntityValue | (ExternalID NDataDecl?)
  defcombinatorp :x_EntityDef, choice([parsec(:x_EntityValue), parsec(:x_ExternalID) |> concat(optional(parsec(:x_NDataDecl)))])
              |> tag(:EntityDef)
              |> label("EntityDef")
  # PEDef ::= EntityValue | ExternalID 
  defcombinatorp :x_PEDef, choice([parsec(:x_EntityValue), parsec(:x_ExternalID)])
          |> tag(:PEDef)
          |> label("PEDef")
  # ExternalID ::= 'SYSTEM' S SystemLiteral  | 'PUBLIC' S PubidLiteral S SystemLiteral 
  defcombinatorp :x_ExternalID, choice([
                    ignore(string("SYSTEM")) |> ignore(parsec(:x_S)) |> concat(parsec(:x_SystemLiteral)) |> tag(:EID_system),
                    ignore(string("PUBLIC")) |> ignore(parsec(:x_S)) |> concat(parsec(:x_PubidLiteral)) |> ignore(parsec(:x_S)) |> concat(parsec(:x_SystemLiteral)) |> tag(:EID_public),
                  ])
               |> tag(:ExternalID)
               |> label("ExternalID")
  # NDataDecl ::= S 'NDATA' S Name 
  defcombinatorp :x_NDataDecl, ignore(parsec(:x_S))
              |> ignore(string("NDATA"))
              |> ignore(parsec(:x_S))
              |> concat(parsec(:x_Name))
              |> tag(:NDataDecl)
              |> label("NDataDecl")

  # Parsed entities
  # TextDecl ::= '<?xml' VersionInfo? EncodingDecl S? '?>'
  defcombinatorp :x_TextDecl, ignore(string("<?xml"))
             |> concat(optional(parsec(:x_VersionInfo)))
             |> concat(parsec(:x_EncodingDecl))
             |> concat(optional(parsec(:x_S)))
             |> ignore(string("?>"))
             |> tag(:TextDecl)
             |> label("TextDecl")
  # extParsedEnt ::= ( TextDecl? content ) - ( Char* RestrictedChar Char* ) 
  defcombinatorp :x_extParsedEnt, optional(parsec(:x_TextDecl))
                 |> concat(parsec(:x_content))
                 |> tag(:extParsedEnt)
                 |> label("extParsedEnt")
  # EncodingDecl ::= S 'encoding' Eq ('"' EncName '"' | "'" EncName "'" ) 
  defcombinatorp :x_EncodingDecl, ignore(parsec(:x_S))
                 |> ignore(string("encoding"))
                 |> ignore(parsec(:x_Eq))
                 |> concat(choice([
                      ignore(string("\"")) |> parsec(:x_EncName) |> ignore(string("\"")),
                      ignore(string("'")) |> parsec(:x_EncName) |> ignore(string("'"))
                   ]))
                 |> tag(:EncodingDecl)
                 |> label("EncodingDecl")
  # EncName ::= [A-Za-z] ([A-Za-z0-9._] | '-')*
  @valid_EncNameFirst Enum.concat([Mod.char_range_to_list("41", "5A"), Mod.char_range_to_list("61", "7A")])
  @valid_EncNameSec Enum.concat([Mod.char_range_to_list("41", "5A"), Mod.char_range_to_list("61", "7A"), Mod.chars_to_list(["30", "39", "2E", "5F"])])
  defcombinatorp :x_EncName, utf8_char(@valid_EncNameFirst)
            |> concat(repeat(@valid_EncNameSec))
            |> tag(:EncName)
            |> label("EncName")
  # NotationDecl ::= '<!NOTATION' S Name S (ExternalID | PublicID) S? '>'
  defcombinatorp :x_NotationDecl, ignore(string("<!NOTATION"))
                 |> ignore(parsec(:x_S))
                 |> concat(parsec(:x_Name))
                 |> concat(choice([parsec(:x_ExternalID), parsec(:x_PublicID)]))
                 |> ignore(parsec(:x_S))
                 |> ignore(string(">"))
                 |> tag(:NotationDecl)
                 |> label("NotationDecl")
  # PublicID ::= 'PUBLIC' S PubidLiteral 
  defcombinatorp :x_PublicID, ignore(string("PUBLIC"))
             |> ignore(parsec(:x_S))
             |> concat(parsec(:x_PubidLiteral))
             |> tag(:PublicID)
             |> label("PublicID")

  # document ::= ( prolog element Misc* ) - ( Char* RestrictedChar Char* ) 
  defcombinatorp :x_document, parsec(:x_prolog)
            |> concat(parsec(:x_element))
            |> concat(repeat(parsec(:x_Misc)))
            |> tag(:document)
            |> label("document")

  # Parser
  defparsecp :parse,
            parsec(:x_document),
            debug: true

end
