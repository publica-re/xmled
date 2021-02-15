defmodule XMLed.Parsers.XPath do
  import NimbleParsec

  def parse_from_file(path) do
    case File.read(path) do
      {:ok, content} -> parse_from_string(content)
      {:error, posix} -> {:error, posix}
    end
  end

  def parse_from_string(input) do
    case xpath(input) do
      {:ok, doc, _, _, _, _} -> {:ok, doc}
      v -> v
    end
  end

  # parsec:XMLed.Parsers.XPath

  defparsecp(:xpath, parsec(:xp_XPath) |> eos())


  # XPath ::= Expr
  defcombinatorp :xp_XPath,
    parsec(:xp_Expr) |> tag(:xpath)
  # ParamList ::= Param ("," Param)*
  defcombinatorp :xp_ParamList,
    parsec(:xp_Param)
    |> ignore(parsec(:xp_S))
    |> concat(repeat(ignore(string(",")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_Param))))
    |> tag(:param_list)
  # Param ::= "$" EQName TypeDeclaration?
  defcombinatorp :xp_Param,
    ignore(string("$"))
    |> concat(parsec(:xp_EQName))
    |> ignore(parsec(:xp_S))
    |> concat(optional(parsec(:xp_TypeDeclaration)))
    |> tag(:param)
  # FunctionBody ::= EnclosedExpr
  defcombinatorp :xp_FunctionBody, parsec(:xp_EnclosedExpr) |> tag(:function_body)
  # EnclosedExpr ::= "{" Expr "}"
  defcombinatorp :xp_EnclosedExpr,
    ignore(string("{"))
    |> ignore(parsec(:xp_S))
    |> concat(parsec(:xp_Expr))
    |> ignore(parsec(:xp_S))
    |> ignore(string("}"))
    |> tag(:enclosed_expr)
  # Expr ::= ExprSingle ("," ExprSingle)*
  defcombinatorp :xp_Expr,
    parsec(:xp_ExprSingle)
    |> ignore(parsec(:xp_S))
    |> concat(repeat(ignore(string(",")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_ExprSingle))))
    |> tag(:expr)
  # ExprSingle ::= ForExpr | LetExpr | QuantifiedExpr | IfExpr | OrExpr
  defcombinatorp :xp_ExprSingle,
    choice([
      parsec(:xp_ForExpr),
      parsec(:xp_LetExpr),
      parsec(:xp_QuantifiedExpr),
      parsec(:xp_IfExpr),
      parsec(:xp_OrExpr)
    ])
  # ForExpr ::= SimpleForClause "return" ExprSingle
  defcombinatorp :xp_ForExpr,
    parsec(:xp_SimpleForClause)
    |> ignore(parsec(:xp_S))
    |> ignore(string("return"))
    |> ignore(parsec(:xp_S))
    |> concat(parsec(:xp_ExprSingle))
    |> tag(:for_expr)
  # SimpleForClause ::= "for" SimpleForBinding ("," SimpleForBinding)*
  defcombinatorp :xp_SimpleForClause,
    ignore(string("for"))
    |> ignore(parsec(:xp_S))
    |> concat(parsec(:xp_SimpleForBinding))
    |> ignore(parsec(:xp_S))
    |> concat(repeat(ignore(string(",")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_SimpleForBinding))))
    |> tag(:simple_for_clause)
  # SimpleForBinding ::= "$" VarName "in" ExprSingle
  defcombinatorp :xp_SimpleForBinding,
      ignore(string("$"))
      |> concat(parsec(:xp_VarName))
      |> ignore(parsec(:xp_S))
      |> ignore(string("in"))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_ExprSingle))
      |> tag(:simple_for_binding)
  # LetExpr ::= SimpleLetClause "return" ExprSingle
  defcombinatorp :xp_LetExpr,
      parsec(:xp_SimpleLetClause)
      |> ignore(parsec(:xp_S))
      |> ignore(string("return"))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_ExprSingle))
      |> tag(:let_expr)
  # SimpleLetClause ::= "let" SimpleLetBinding ("," SimpleLetBinding)*
  defcombinatorp :xp_SimpleLetClause,
      ignore(string("let"))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_SimpleLetBinding))
      |> ignore(parsec(:xp_S))
      |> concat(repeat(ignore(string(",")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_SimpleLetBinding))))
      |> tag(:simple_let_clause)
  # SimpleLetBinding ::= "$" VarName ":=" ExprSingle
  defcombinatorp :xp_SimpleLetBinding,
      ignore(string("$"))
      |> concat(parsec(:xp_VarName))
      |> ignore(parsec(:xp_S))
      |> ignore(string(":="))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_ExprSingle))
      |> tag(:simple_let_binding)
  # QuantifiedExpr ::= ("some" | "every") "$" VarName "in" ExprSingle ("," "$" VarName "in" ExprSingle)* "satisfies" ExprSingle
  defcombinatorp :xp_QuantifiedExpr,
      choice([
        string("some") |> replace(:some),
        string("every") |> replace(:every)
      ])
      |> ignore(parsec(:xp_S))
      |> (ignore(string("$")) |> concat(parsec(:xp_VarName)) |> ignore(parsec(:xp_S)) |> ignore(string("in")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_ExprSingle)) |> tag(:v_i_e))
      |> ignore(parsec(:xp_S))
      |> concat(repeat(ignore(string(",")) |> ignore(parsec(:xp_S)) |> (ignore(string("$")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_VarName)) |> ignore(parsec(:xp_S)) |> ignore(string("in")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_ExprSingle)) |> tag(:v_i_e))))
      |> ignore(parsec(:xp_S))
      |> ignore(string("satisfies"))
      |> ignore(parsec(:xp_S))
      |> (concat(parsec(:xp_ExprSingle)) |> tag(:satisfies))
      |> tag(:quantified_expr)
  # IfExpr ::= "if" "(" Expr ")" "then" ExprSingle "else" ExprSingle
  defcombinatorp :xp_IfExpr,
      ignore(string("if"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> (concat(parsec(:xp_Expr)) |> tag(:cond))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("then"))
      |> ignore(parsec(:xp_S))
      |> (concat(parsec(:xp_ExprSingle)) |> tag(:positive))
      |> ignore(parsec(:xp_S))
      |> ignore(string("else"))
      |> ignore(parsec(:xp_S))
      |> (concat(parsec(:xp_ExprSingle)) |> tag(:negative))
      |> tag(:if)
  # OrExpr ::= AndExpr ( "or" AndExpr )*
  defcombinatorp :xp_OrExpr,
      parsec(:xp_AndExpr)
      |> ignore(parsec(:xp_S))
      |> concat(repeat(ignore(string("or")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_AndExpr))))
      |> tag(:or)
  # AndExpr ::= ComparisonExpr ( "and" ComparisonExpr )*
  defcombinatorp :xp_AndExpr,
      parsec(:xp_ComparisonExpr)
      |> ignore(parsec(:xp_S))
      |> concat(repeat(ignore(string("and")) |> ignore(parsec(:xp_S))  |> concat(parsec(:xp_ComparisonExpr))))
      |> tag(:and)
  # ComparisonExpr ::= StringConcatExpr ( (ValueComp | GeneralComp | NodeComp) StringConcatExpr )?
  defcombinatorp :xp_ComparisonExpr,
      parsec(:xp_StringConcatExpr)
      |> ignore(parsec(:xp_S))
      |> concat(optional(choice([parsec(:xp_ValueComp), parsec(:xp_GeneralComp), parsec(:xp_NodeComp)]) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_StringConcatExpr))))
      |> tag(:comparison_expr)
  # StringConcatExpr ::= RangeExpr ( "||" RangeExpr )*
  defcombinatorp :xp_StringConcatExpr,
      parsec(:xp_RangeExpr)
      |> ignore(parsec(:xp_S))
      |> concat(repeat(ignore(string("||") |> concat(parsec(:xp_RangeExpr)))))
      |> ignore(parsec(:xp_S))
      |> tag(:string_concat_expr)
  # RangeExpr ::= AdditiveExpr ( "to" AdditiveExpr )?
  defcombinatorp :xp_RangeExpr,
      parsec(:xp_AdditiveExpr)
      |> ignore(parsec(:xp_S))
      |> concat(optional(ignore(string("to")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_AdditiveExpr))))
      |> tag(:range_expr)
  # AdditiveExpr ::= MultiplicativeExpr ( ("+" | "-") MultiplicativeExpr )*
  defcombinatorp :xp_AdditiveExpr,
      parsec(:xp_MultiplicativeExpr)
      |> concat(repeat(ignore(parsec(:xp_S)) |> choice([string("+") |> replace(:add), string("-") |> replace(:sub)]) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_MultiplicativeExpr))))
      |> tag(:additive_expr)
  # MultiplicativeExpr ::= UnionExpr ( ("*" | "div" | "idiv" | "mod") UnionExpr )*
  defcombinatorp :xp_MultiplicativeExpr,
      parsec(:xp_UnionExpr)
      |> concat(repeat(ignore(parsec(:xp_S)) |> choice([string("*") |> replace(:times), string("div") |> replace(:div), string("idiv") |> replace(:idiv), string("mod") |> replace(:mod)]) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_UnionExpr))))
      |> tag(:multiplicative_expr)
  # UnionExpr ::= IntersectExceptExpr ( ("union" | "|") IntersectExceptExpr )*
  defcombinatorp :xp_UnionExpr,
      parsec(:xp_IntersectExceptExpr)
      |> concat(repeat(ignore(parsec(:xp_S)) |> choice([string("union") |> replace(:union), string("|") |> replace(:union)]) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_IntersectExceptExpr))))
      |> tag(:union_expr)
  # IntersectExceptExpr ::= InstanceofExpr ( ("intersect" | "except") InstanceofExpr )*
  defcombinatorp :xp_IntersectExceptExpr,
      parsec(:xp_InstanceofExpr)
      |> concat(repeat(ignore(parsec(:xp_S)) |> choice([string("intersect") |> replace(:intersect), string("except") |> replace(:except)]) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_InstanceofExpr))))
      |> tag(:intersect_except_expr)
  # InstanceofExpr ::= TreatExpr ( "instance" "of" SequenceType )?
  defcombinatorp :xp_InstanceofExpr,
      parsec(:xp_TreatExpr)
      |> concat(optional(ignore(parsec(:xp_S)) |> ignore(string("instance")) |> ignore(parsec(:xp_S)) |> ignore(string("of")) |> concat(parsec(:xp_SequenceType))))
      |> tag(:instanceof_expr)
  # TreatExpr ::= CastableExpr ( "treat" "as" SequenceType )?
  defcombinatorp :xp_TreatExpr,
      parsec(:xp_CastableExpr)
      |> concat(optional(ignore(parsec(:xp_S)) |> ignore(string("treat")) |> ignore(parsec(:xp_S)) |> ignore(string("as")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_SequenceType))))
      |> tag(:treat_expr)
  # CastableExpr ::= CastExpr ( "castable" "as" SingleType )?
  defcombinatorp :xp_CastableExpr,
      parsec(:xp_CastExpr)
      |> concat(optional(ignore(parsec(:xp_S)) |> ignore(string("castable")) |> ignore(parsec(:xp_S)) |> ignore(string("as")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_SingleType))))
      |> tag(:castable_expr)
  # CastExpr ::= UnaryExpr ( "cast" "as" SingleType )?
  defcombinatorp :xp_CastExpr,
      parsec(:xp_UnaryExpr)
      |> concat(optional(ignore(parsec(:xp_S)) |> ignore(string("cast")) |> ignore(parsec(:xp_S)) |> ignore(string("as")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_SingleType))))
      |> tag(:cast_expr)
  # UnaryExpr ::= ("-" | "+")* ValueExpr
  defcombinatorp :xp_UnaryExpr,
      repeat(choice([string("-") |> replace(:minus), string("+") |> replace(:plus)]))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_ValueExpr))
      |> tag(:unary_expr)
  # ValueExpr ::= SimpleMapExpr
  defcombinatorp :xp_ValueExpr,
      parsec(:xp_SimpleMapExpr)
      |> tag(:value_expr)
  # GeneralComp ::= "=" | "!=" | "<" | "<=" | ">" | ">="
  defcombinatorp :xp_GeneralComp,
      choice([
        string("=") |> replace(:=),
        string("!=") |> replace(:!=),
        string("<") |> replace(:<),
        string("<=") |> replace(:<=),
        string(">") |> replace(:>),
        string(">=") |> replace(:>=)
      ])
      |> tag(:general_comp)
  # ValueComp ::= "eq" | "ne" | "lt" | "le" | "gt" | "ge"
  defcombinatorp :xp_ValueComp,
      choice([
        string("eq") |> replace(:eq),
        string("ne") |> replace(:ne),
        string("lt") |> replace(:lt),
        string("le") |> replace(:le),
        string("gt") |> replace(:gt),
        string("ge") |> replace(:ge)
      ])
      |> tag(:value_comp)
  # NodeComp ::= "is" | "<<" | ">>"
  defcombinatorp :xp_NodeComp,
      choice([
        string("is") |> replace(:is),
        string("<<") |> replace(:precedes),
        string(">>") |> replace(:follows)
      ])
      |> tag(:node_comp)
  # SimpleMapExpr ::= PathExpr ("!" PathExpr)*
  defcombinatorp :xp_SimpleMapExpr,
      parsec(:xp_PathExpr)
      |> concat(repeat(ignore(parsec(:xp_S)) |> ignore(string("!")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_PathExpr))))
      |> tag(:simple_map_expr)
  # PathExpr ::= ("/" RelativePathExpr?) | ("//" RelativePathExpr) | RelativePathExpr 	/* xgc: leading-lone-slash */
  defcombinatorp :xp_PathExpr,
      choice([
        string("//") |> ignore(parsec(:xp_S)) |> replace(:root_descendant) |> concat(parsec(:xp_RelativePathExpr)),
        string("/") |> ignore(parsec(:xp_S)) |> replace(:root) |> concat(parsec(:xp_RelativePathExpr)),
        parsec(:xp_RelativePathExpr),
      ])
      |> tag(:path_expr)
  # RelativePathExpr ::= StepExpr (("/" | "//") StepExpr)*
  defcombinatorp :xp_RelativePathExpr,
      parsec(:xp_StepExpr)
      |> ignore(parsec(:xp_S))
      |> concat(repeat(choice([string("//")  |> replace(:descendant), string("/") |> replace(:child)]) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_StepExpr))))
      |> tag(:relative_path_expr)
  # StepExpr ::= PostfixExpr | AxisStep
  defcombinatorp :xp_StepExpr,
      choice([
        parsec(:xp_PostfixExpr),
        parsec(:xp_AxisStep)
      ])
      |> tag(:step_expr)
  # AxisStep ::= (ReverseStep | ForwardStep) PredicateList
  defcombinatorp :xp_AxisStep,
      choice([
        parsec(:xp_ReverseStep),
        parsec(:xp_ForwardStep)
      ])
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_PredicateList))
      |> tag(:axis_step)
  # ForwardStep ::= (ForwardAxis NodeTest) | AbbrevForwardStep
  defcombinatorp :xp_ForwardStep,
      choice([
        parsec(:xp_ForwardAxis) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_NodeTest)),
        parsec(:xp_AbbrevForwardStep)
      ])
      |> tag(:forward_step)
# ForwardAxis ::= ("child" "::") | ("descendant" "::") | ("attribute" "::") | ("self" "::") | ("descendant-or-self" "::") | ("following-sibling" "::") | ("following" "::") | ("namespace" "::")
defcombinatorp :xp_ForwardAxis,
      choice([
        string("child") |> replace(:child),
        string("descendant") |> replace(:descendant),
        string("attribute") |> replace(:attribute),
        string("self") |> replace(:self),
        string("descendant-or-self") |> replace(:descendant_or_self),
        string("following-sibling") |> replace(:following_sibling),
        string("following") |> replace(:following),
        string("namespace") |> replace(:namespace)
      ])
      |> ignore(parsec(:xp_S))
      |> ignore(string("::"))
      |> tag(:forward_axis)
  # AbbrevForwardStep ::= "@"? NodeTest
  defcombinatorp :xp_AbbrevForwardStep,
      optional(string("@") |> replace(:attribute) |> ignore(parsec(:xp_S)))
      |> concat(parsec(:xp_NodeTest))
      |> tag(:abbrev_forward_step)
  # ReverseStep ::= (ReverseAxis NodeTest) | AbbrevReverseStep
  defcombinatorp :xp_ReverseStep,
      choice([
        parsec(:xp_ReverseAxis) |> concat(parsec(:xp_NodeTest)),
        parsec(:xp_AbbrevReverseStep)
      ])
      |> tag(:reverse_step)
  # ReverseAxis ::= ("parent" "::") | ("ancestor" "::") | ("preceding-sibling" "::") | ("preceding" "::") | ("ancestor-or-self" "::")
  defcombinatorp :xp_ReverseAxis,
      choice([
        string("parent") |> replace(:parent),
        string("ancestor") |> replace(:ancestor),
        string("preceding-sibling") |> replace(:preceding_sibling),
        string("preceding") |> replace(:preceding),
        string("ancestor-or-self") |> replace(:ancestor_or_self)
      ])
      |> ignore(parsec(:xp_S))
      |> ignore(string("::"))
      |> tag(:reverse_axis)
  # AbbrevReverseStep ::= ".."
  defcombinatorp :xp_AbbrevReverseStep,
      string("..")
      |> replace(:abbrev_reverse_step)
  # NodeTest ::= KindTest | NameTest
  defcombinatorp :xp_NodeTest,
      choice([
        parsec(:xp_KindTest),
        parsec(:xp_NameTest)
      ])
      |> tag(:node_test)
  # NameTest ::= EQName | Wildcard
  defcombinatorp :xp_NameTest,
      choice([
        parsec(:xp_EQName),
        parsec(:xp_Wildcard)
      ])
      |> tag(:name_test)
  # Wildcard ::= "*" | (NCName ":" "*") | ("*" ":" NCName) | (BracedURILiteral "*")
  defcombinatorp :xp_Wildcard,
      choice([
        string("*") |> replace(:wildcard),
        parsec(:xp_NCName) |> ignore(parsec(:xp_S)) |> ignore(string(":")) |> ignore(parsec(:xp_S)) |> ignore(string("*")) |> tag(:suffix_wildcard),
        ignore(string("*")) |> ignore(parsec(:xp_S)) |> ignore(string(":")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_NCName)) |> tag(:prefix_wildcard),
        parsec(:xp_BracedURILiteral) |> ignore(parsec(:xp_S)) |> ignore(string("*")) |> tag(:braceduri_wildcard)
      ])
  # PostfixExpr ::= PrimaryExpr (Predicate | ArgumentList)*
  defcombinatorp :xp_PostfixExpr,
      parsec(:xp_PrimaryExpr)
      |> ignore(parsec(:xp_S))
      |> concat(repeat(choice([parsec(:xp_Predicate), parsec(:xp_ArgumentList)])))
      |> tag(:postfix_expr)
  # ArgumentList ::= "(" (Argument ("," Argument)*)? ")"
  defcombinatorp :xp_ArgumentList,
      ignore(string("("))
      |> concat(optional(ignore(parsec(:xp_S)) |> parsec(:xp_Argument) |> concat(repeat(ignore(parsec(:xp_S)) |> ignore(string(",")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_Argument))))))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:argument_list)
  # PredicateList ::= Predicate*
  defcombinatorp :xp_PredicateList,
      repeat(parsec(:xp_Predicate))
      |> tag(:predicate_list)
  # Predicate ::= "[" Expr "]"
  defcombinatorp :xp_Predicate,
      ignore(string("["))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_Expr))
      |> ignore(parsec(:xp_S))
      |> ignore(string("]"))
      |> tag(:predicate)
  # PrimaryExpr ::= Literal | VarRef | ParenthesizedExpr | ContextItemExpr | FunctionCall | FunctionItemExpr
  defcombinatorp :xp_PrimaryExpr,
      choice([
        parsec(:xp_Literal),
        parsec(:xp_VarRef),
        parsec(:xp_ParenthesizedExpr),
        parsec(:xp_ContextItemExpr),
        parsec(:xp_FunctionCall),
        parsec(:xp_FunctionCall),
        parsec(:xp_FunctionItemExpr)
      ])
      |> tag(:primary_expr)
  # Literal ::= NumericLiteral | StringLiteral
  defcombinatorp :xp_Literal,
      choice([
        parsec(:xp_NumericLiteral),
        parsec(:xp_StringLiteral)
      ])
      |> tag(:literal)
  # NumericLiteral ::= IntegerLiteral | DecimalLiteral | DoubleLiteral
  defcombinatorp :xp_NumericLiteral,
      choice([
        parsec(:xp_IntegerLiteral),
        parsec(:xp_DecimalLiteral),
        parsec(:xp_DoubleLiteral)
      ])
      |> tag(:numeric_literal)
  # VarRef ::= "$" VarName
  defcombinatorp :xp_VarRef,
      ignore(string("$"))
      |> concat(parsec(:xp_VarName))
      |> tag(:var_ref)
  # VarName ::= EQName
  defcombinatorp :xp_VarName,
      parsec(:xp_EQName)
      |> tag(:var_name)
  # ParenthesizedExpr ::= "(" Expr? ")"
  defcombinatorp :xp_ParenthesizedExpr,
      ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> concat(optional(parsec(:xp_Expr) |> ignore(parsec(:xp_S))))
      |> ignore(string(")"))
      |> tag(:parenthesized_expr)
  # ContextItemExpr ::= "."
  defcombinatorp :xp_ContextItemExpr,
      string(".") |> replace(:context_item_expr)
  # FunctionCall ::= EQName ArgumentList
  defcombinatorp :xp_FunctionCall,
      parsec(:xp_EQName)
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_ArgumentList))
      |> tag(:function_call)
  # Argument ::= ExprSingle | ArgumentPlaceholder
  defcombinatorp :xp_Argument,
      choice([
        parsec(:xp_ExprSingle),
        parsec(:xp_ArgumentPlaceholder)
      ])
      |> tag(:argument)
  # ArgumentPlaceholder ::= "?"
  defcombinatorp :xp_ArgumentPlaceholder,
      string("?") |> replace(:argument_placeholder)
  # FunctionItemExpr ::= NamedFunctionRef | InlineFunctionExpr
  defcombinatorp :xp_FunctionItemExpr,
      choice([
        parsec(:xp_NamedFunctionRef),
        parsec(:xp_InlineFunctionExpr)
      ])
      |> tag(:function_item_expr)
  # NamedFunctionRef ::= EQName "#" IntegerLiteral
  defcombinatorp :xp_NamedFunctionRef,
      parsec(:xp_EQName)
      |> ignore(parsec(:xp_S))
      |> ignore(string("#"))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_IntegerLiteral))
      |> tag(:named_function_ref)
  # InlineFunctionExpr ::= "function" "(" ParamList? ")" ("as" SequenceType)? FunctionBody
  defcombinatorp :xp_InlineFunctionExpr,
      ignore(string("function"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> concat(optional(parsec(:xp_ParamList) |> ignore(parsec(:xp_S))))
      |> ignore(string(")"))
      |> ignore(parsec(:xp_S))
      |> concat(optional(ignore(string("as")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_SequenceType)) |> ignore(parsec(:xp_S))))
      |> concat(parsec(:xp_FunctionBody))
      |> tag(:inline_function_expr)
  # SingleType ::= SimpleTypeName "?"?
  defcombinatorp :xp_SingleType,
      parsec(:xp_SimpleTypeName)
      |> concat(optional(ignore(parsec(:xp_S)) |> string("?") |> replace(:optional)))
      |> tag(:single_type)
  # TypeDeclaration ::= "as" SequenceType
  defcombinatorp :xp_TypeDeclaration,
      ignore(string("as"))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_SequenceType))
      |> tag(:type_declaration)
  # SequenceType ::= ("empty-sequence" "(" ")") | (ItemType OccurrenceIndicator?)
  defcombinatorp :xp_SequenceType,
      choice([
        string("empty-sequence") |> replace(:empty_sequence) |> ignore(parsec(:xp_S)) |> ignore(string("(")) |> ignore(parsec(:xp_S)) |> ignore(string(")")),
        parsec(:xp_ItemType) |> ignore(parsec(:xp_S)) |> concat(optional(parsec(:xp_OccurenceIndicator)))
      ])
      |> tag(:sequence_type)
  # OccurrenceIndicator ::= "?" | "*" | "+"
  defcombinatorp :xp_OccurenceIndicator,
      choice([
        string("?") |> replace(:maybe),
        string("*") |> replace(:some),
        string("+") |> replace(:many)
      ])
      |> tag(:occurence_indicator)
  # ItemType ::= KindTest | ("item" "(" ")") | FunctionTest | AtomicOrUnionType | ParenthesizedItemType
  defcombinatorp :xp_ItemType,
      choice([
        parsec(:xp_KindTest),
        string("item") |> replace(:item) |> ignore(parsec(:xp_S)) |> ignore(string("(")) |> ignore(parsec(:xp_S)) |> ignore(string(")")),
        parsec(:xp_FunctionTest),
        parsec(:xp_AtomicOrUnionType),
        parsec(:xp_ParenthesizedItemType)
      ])
      |> tag(:item_type)
  # AtomicOrUnionType ::= EQName
  defcombinatorp :xp_AtomicOrUnionType,
      parsec(:xp_EQName)
      |> tag(:atomic_or_union_type)
  # KindTest ::= DocumentTest | ElementTest | AttributeTest | SchemaElementTest | SchemaAttributeTest | PITest | CommentTest | TextTest | NamespaceNodeTest | AnyKindTest
  defcombinatorp :xp_KindTest,
      choice([
        parsec(:xp_DocumentTest),
        parsec(:xp_ElementTest),
        parsec(:xp_AttributeTest),
        parsec(:xp_SchemaElementTest),
        parsec(:xp_SchemaAttributeTest),
        parsec(:xp_PITest),
        parsec(:xp_CommentTest),
        parsec(:xp_TextTest),
        parsec(:xp_NamespaceNodeTest),
        parsec(:xp_AnyKindTest)
      ])
      |> tag(:kind_test)
  # AnyKindTest ::= "node" "(" ")"
  defcombinatorp :xp_AnyKindTest,
      ignore(string("node"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:any_kind_tag)
  # DocumentTest ::= "document-node" "(" (ElementTest | SchemaElementTest)? ")"
  defcombinatorp :xp_DocumentTest,
      ignore(string("document-node"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> concat(optional(ignore(parsec(:xp_S)) |> choice([parsec(:xp_ElementTest), parsec(:xp_SchemaElementTest)])))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:document_test)
  # TextTest ::= "text" "(" ")"
  defcombinatorp :xp_TextTest,
      ignore(string("text"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:text_test)
  # CommentTest ::= "comment" "(" ")"
  defcombinatorp :xp_CommentTest,
      ignore(string("comment"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:comment_test)
  # NamespaceNodeTest ::= "namespace-node" "(" ")"
  defcombinatorp :xp_NamespaceNodeTest,
      ignore(string("namespace-node"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:namespace_node_test)
  # PITest ::= "processing-instruction" "(" (NCName | StringLiteral)? ")"
  defcombinatorp :xp_PITest,
      ignore(string("processing-instruction"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> concat(optional(ignore(parsec(:xp_S)) |> choice([parsec(:xp_NCName), parsec(:xp_StringLiteral)])))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:pi_test)
  # AttributeTest ::= "attribute" "(" (AttribNameOrWildcard ("," TypeName)?)? ")"
  defcombinatorp :xp_AttributeTest,
      ignore(string("attribute"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> concat(optional(ignore(parsec(:xp_S)) |> parsec(:xp_AttribNameOrWildcard) |> concat(optional(ignore(parsec(:xp_S)) |> ignore(string(",") |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_TypeName)))))))
      |> ignore(parsec(:xp_S))
      |> tag(:attribute_test)
  # AttribNameOrWildcard ::= AttributeName | "*"
  defcombinatorp :xp_AttribNameOrWildcard,
      choice([
        parsec(:xp_AttributeName),
        string("*") |> replace(:wildcard)
      ])
      |> tag(:attrib_name_or_wildcard)
  # SchemaAttributeTest ::= "schema-attribute" "(" AttributeDeclaration ")"
  defcombinatorp :xp_SchemaAttributeTest,
      ignore(string("schema-attribute"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_AttributeDeclaration))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:schema_attribute_test)
  # AttributeDeclaration ::= AttributeName
  defcombinatorp :xp_AttributeDeclaration,
      parsec(:xp_AttributeName)
      |> tag(:attribute_declaration)
  # ElementTest ::= "element" "(" (ElementNameOrWildcard ("," TypeName "?"?)?)? ")"
  defcombinatorp :xp_ElementTest,
      ignore(string("element"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> concat(optional(ignore(parsec(:xp_S)) |> parsec(:xp_ElementNameOrWildcard) |> concat(optional(ignore(parsec(:xp_S)) |> ignore(string(",")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_TypeName)) |> concat(ignore(parsec(:xp_S)) |> optional(string("?") |> replace(:optional)))))))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:element_test)
  # ElementNameOrWildcard ::= ElementName | "*"
  defcombinatorp :xp_ElementNameOrWildcard,
      choice([
        parsec(:xp_ElementName),
        string("*") |> replace(:wildcard)
      ])
      |> tag(:element_name_or_wildcard)
  # SchemaElementTest ::= "schema-element" "(" ElementDeclaration ")"
  defcombinatorp :xp_SchemaElementTest,
      ignore(string("schema-element"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_ElementDeclaration))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:schema_element_test)
  # ElementDeclaration ::= ElementName
  defcombinatorp :xp_ElementDeclaration,
      parsec(:xp_ElementName)
      |> tag(:element_declaration)
  # AttributeName ::= EQName
  defcombinatorp :xp_AttributeName,
      parsec(:xp_EQName)
      |> tag(:attribute_name)
  # ElementName ::= EQName
  defcombinatorp :xp_ElementName,
      parsec(:xp_EQName)
      |> tag(:element_name)
  # SimpleTypeName ::= TypeName
  defcombinatorp :xp_SimpleTypeName,
      parsec(:xp_TypeName)
      |> tag(:simple_type_name)
  # TypeName ::= EQName
  defcombinatorp :xp_TypeName,
      parsec(:xp_TypeName)
      |> tag(:type_name)
  # FunctionTest ::= AnyFunctionTest | TypedFunctionTest
  defcombinatorp :xp_FunctionTest,
      choice([
        parsec(:xp_AnyFunctionTest),
        parsec(:xp_TypedFunctionTest)
      ])
      |> tag(:function_test)
  # AnyFunctionTest ::= "function" "(" "*" ")"
  defcombinatorp :xp_AnyFunctionTest,
      ignore(string("function"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> ignore(string("*"))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:any_function_test)
  # TypedFunctionTest ::= "function" "(" (SequenceType ("," SequenceType)*)? ")" "as" SequenceType
  defcombinatorp :xp_TypedFunctionTest,
      ignore(string("function"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("("))
      |> concat(optional(ignore(parsec(:xp_S)) |> parsec(:xp_SequenceType) |> concat(repeat(ignore(parsec(:xp_S)) |> ignore(string(",")) |> ignore(parsec(:xp_S)) |> concat(parsec(:xp_SequenceType))))))
      |> ignore(parsec(:xp_S))
      |> ignore(string("as"))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_SequenceType))
      |> tag(:typed_function_test)
  # ParenthesizedItemType ::= "(" ItemType ")"
  defcombinatorp :xp_ParenthesizedItemType,
      ignore(string("("))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_ItemType))
      |> ignore(parsec(:xp_S))
      |> ignore(string(")"))
      |> tag(:parenthesized_item_type)
  # EQName ::= QName | URIQualifiedName
  defcombinatorp :xp_EQName,
      choice([
        parsec(:xp_QName),
        parsec(:xp_URIQualifiedName)
      ])
      |> tag(:EQ_name)
  # IntegerLiteral ::= Digits
  defcombinatorp :xp_IntegerLiteral,
        parsec(:xp_Digits)
        |> tag(:integer_literal)
  # DecimalLiteral ::= ("." Digits) | (Digits "." [0-9]*)
  defcombinatorp :xp_DecimalLiteral,
      choice([
        ignore(string(".")) |> ignore(parsec(:xp_S)) |> replace(:decimal) |> concat(parsec(:xp_Digits)),
        parsec(:xp_Digits) |> ignore(parsec(:xp_S)) |> concat(ignore(string("."))|> ignore(parsec(:xp_S)) |> replace(:decimal)) |> concat(repeat(utf8_char([?0..?9])))
      ])
      |> tag(:decimal_literal)
  # DoubleLiteral ::= (("." Digits) | (Digits ("." [0-9]*)?)) [eE] [+-]? Digits
  defcombinatorp :xp_DoubleLiteral,
      choice([
        ignore(string(".")) |> ignore(parsec(:xp_S)) |> replace(:decimal) |> concat(parsec(:xp_Digits)),
        parsec(:xp_Digits) |> ignore(parsec(:xp_S)) |> concat(optional(ignore(string("."))  |> replace(:decimal) |> ignore(parsec(:xp_S)) |> concat(repeat(utf8_char([?0..?9])))))
      ])
      |> ignore(parsec(:xp_S))
      |> concat(utf8_char([?e, ?E]) |> replace(:exponential))
      |> ignore(parsec(:xp_S))
      |> concat(parsec(:xp_Digits))
      |> tag(:double_literal)
  # StringLiteral ::= ('"' (EscapeQuot | [^"])* '"') | ("'" (EscapeApos | [^'])* "'")
  defcombinatorp :xp_StringLiteral,
      choice([
        ignore(string("\"")) |> concat(repeat(choice([parsec(:xp_EscapeQuot), utf8_char([not: ?"])]))) |> ignore(string("\"")),
        ignore(string("'")) |> concat(repeat(choice([parsec(:xp_EscapeQuot), utf8_char([not: ?'])]))) |> ignore(string("'"))
      ])
      |> tag(:string_literal)
  # URIQualifiedName ::= BracedURILiteral NCName
  defcombinatorp :xp_URIQualifiedName,
      parsec(:xp_BracedURILiteral)
      |> concat(parsec(:xp_NCName))
      |> tag(:URI_qualified_name)
  # BracedURILiteral ::= "Q" "{" [^{}]* "}"
  defcombinatorp :xp_BracedURILiteral,
      ignore(string("Q"))
      |> ignore(parsec(:xp_S))
      |> ignore(string("{"))
      |> ignore(parsec(:xp_S))
      |> concat(repeat(utf8_char([not: ?{, not: ?}])))
      |> ignore(parsec(:xp_S))
      |> reduce({List, :to_string, []})
      |> ignore(string("}"))
      |> tag(:braced_uri_literal)
  # EscapeQuot ::= '""'
  defcombinatorp :xp_EscapeQuot,
      string("\"\"") |> replace(:escape_quot)
  # EscapeApos ::= "''"
  defcombinatorp :xp_EscapeApos,
      string("''") |> replace(:escape_apos)
  # Comment ::= "(:" (CommentContents | Comment)* ":)"
  defcombinatorp :xp_Comment,
      ignore(string("(:"))
      |> ignore(parsec(:xp_S))
      |> concat(repeat(choice([parsec(:xp_CommentContents), parsec(:xp_Comment)])))
      |> ignore(parsec(:xp_S))
      |> ignore(string(":)"))
      |> tag(:comment)
  # Digits ::= [0-9]+
  defcombinatorp :xp_Digits,
      times(utf8_char([?0..?9]), min: 1)
      |> tag(:digits)
  # CommentContents ::= (Char+ - (Char* ('(:' | ':)') Char*))
  defcombinatorp :xp_CommentContents,
      repeat(lookahead_not(choice([string("(:"), string(":)")])) |> parsec(:xp_Char))
      |> reduce({List, :to_string, []})
      |> tag(:comment_contents)
  # QName ::= PrefixedName | UnprefixedName
  defcombinatorp :xp_QName,
      choice([
        parsec(:xp_PrefixedName),
        parsec(:xp_UnprefixedName)
      ])
      |> tag(:Q_name)
  # PrefixedName ::= Prefix ':' LocalPart
  defcombinatorp :xp_PrefixedName,
      parsec(:xp_Prefix)
      |> ignore(parsec(:xp_S))
      |> ignore(string(":"))
      |> ignore(parsec(:xp_S))
      |> parsec(:xp_LocalPart)
      |> tag(:prefixed_name)
  # UnprefixedName ::= LocalPart
  defcombinatorp :xp_UnprefixedName,
      parsec(:xp_LocalPart)
      |> tag(:unprefixed_name)
  # Prefix ::= NCName
  defcombinatorp :xp_Prefix,
      parsec(:xp_NCName)
      |> tag(:prefix)
  # LocalPart ::= NCName
  defcombinatorp :xp_LocalPart,
      parsec(:xp_NCName)
      |> tag(:local_part)
  # NCName ::= Name - (Char* ':' Char*)  (* An XML Name, minus the ":" *)
  defcombinatorp :xp_NCName,
      lookahead_not(string(":")) |> parsec(:xp_Name)
      |> tag(:NC_name)
  # Name ::= NameStartChar (NameChar)*
  defcombinatorp :xp_Name,
      parsec(:xp_NameStartChar)
      |> concat(repeat(parsec(:xp_NameChar)))
      |> reduce({List, :to_string, []})
      |> tag(:name)
  # NameStartChar ::= ":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]
  defcombinatorp :xp_NameStartChar,
      utf8_char([?:, ?A..?Z, ?_, ?a..?z, 0xC0..0xD6, 0xD8..0xF6, 0xF8..0x2FF, 0x370..0x37D, 0x37F..0x1FFF, 0x200C..0x200D, 0x2070..0x218F, 0x2C00..0x2FEF, 0x3001..0xD7FF, 0xF900..0xFDCF])
  # NameChar ::= NameStartChar | "-" | "." | [0-9] | #xB7 | [#x0300-#x036F] | [#x203F-#x2040]
  defcombinatorp :xp_NameChar,
      utf8_char([?:, ?A..?Z, ?_, ?a..?z, 0xC0..0xD6, 0xD8..0xF6, 0xF8..0x2FF, 0x370..0x37D, 0x37F..0x1FFF, 0x200C..0x200D, 0x2070..0x218F, 0x2C00..0x2FEF, 0x3001..0xD7FF, 0xF900..0xFDCF, ?-, ?., ?0..?9, 0xB7, 0x300..0x36F, 0x203F..0x2040]) |> label("character of name")
  # Char ::= #x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]
  defcombinatorp :xp_Char,
      utf8_char([0x1..0xD7FF, 0xE000..0xFFFD, 0x10000..0x10FFFF]) |> label("Char")

  # S ::= (#x20 | #x9 | #xD | #xA)+
  defcombinatorp :xp_S,
      repeat(utf8_char([0x20, 0x9, 0xD, 0xA]))


  # parsec:XMLed.Parsers.XPath
end
