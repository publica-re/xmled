# Generated from .\lib\Parsers\XPath.ex.exs, do not edit.
# Generated at 2021-02-12 17:20:57Z.

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

  defp xp_S__0(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 32 or x0 === 9 or x0 === 13 or x0 === 10 do
    xp_S__2(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case(x0) do
          10 ->
            {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}

          _ ->
            line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_S__0(rest, acc, stack, context, line, offset) do
    xp_S__1(rest, acc, stack, context, line, offset)
  end

  defp xp_S__2(rest, acc, stack, context, line, offset) do
    xp_S__0(rest, acc, stack, context, line, offset)
  end

  defp xp_S__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Char__0(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when (x0 >= 1 and x0 <= 55295) or (x0 >= 57344 and x0 <= 65533) or
              (x0 >= 65536 and x0 <= 1_114_111) do
    xp_Char__1(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case(x0) do
          10 ->
            {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}

          _ ->
            line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_Char__0(rest, _acc, _stack, context, line, offset) do
    {:error, "expected Char", rest, context, line, offset}
  end

  defp xp_Char__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NameChar__0(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 === 58 or (x0 >= 65 and x0 <= 90) or x0 === 95 or (x0 >= 97 and x0 <= 122) or
              (x0 >= 192 and x0 <= 214) or (x0 >= 216 and x0 <= 246) or (x0 >= 248 and x0 <= 767) or
              (x0 >= 880 and x0 <= 893) or (x0 >= 895 and x0 <= 8191) or
              (x0 >= 8204 and x0 <= 8205) or (x0 >= 8304 and x0 <= 8591) or
              (x0 >= 11264 and x0 <= 12271) or (x0 >= 12289 and x0 <= 55295) or
              (x0 >= 63744 and x0 <= 64975) or x0 === 45 or x0 === 46 or (x0 >= 48 and x0 <= 57) or
              x0 === 183 or (x0 >= 768 and x0 <= 879) or (x0 >= 8255 and x0 <= 8256) do
    xp_NameChar__1(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_NameChar__0(rest, _acc, _stack, context, line, offset) do
    {:error, "expected character of name", rest, context, line, offset}
  end

  defp xp_NameChar__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NameStartChar__0(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 58 or (x0 >= 65 and x0 <= 90) or x0 === 95 or (x0 >= 97 and x0 <= 122) or
              (x0 >= 192 and x0 <= 214) or (x0 >= 216 and x0 <= 246) or (x0 >= 248 and x0 <= 767) or
              (x0 >= 880 and x0 <= 893) or (x0 >= 895 and x0 <= 8191) or
              (x0 >= 8204 and x0 <= 8205) or (x0 >= 8304 and x0 <= 8591) or
              (x0 >= 11264 and x0 <= 12271) or (x0 >= 12289 and x0 <= 55295) or
              (x0 >= 63744 and x0 <= 64975) do
    xp_NameStartChar__1(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_NameStartChar__0(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected utf8 codepoint equal to ':' or in the range 'A' to 'Z' or equal to '_' or in the range 'a' to 'z' or in the range 'À' to 'Ö' or in the range 'Ø' to 'ö' or in the range 'ø' to '˿' or in the range 'Ͱ' to 'ͽ' or in the range 'Ϳ' to '῿' or in the range '‌' to '‍' or in the range '⁰' to '↏' or in the range 'Ⰰ' to '⿯' or in the range '、' to '퟿' or in the range '豈' to '﷏'",
     rest, context, line, offset}
  end

  defp xp_NameStartChar__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Name__0(rest, acc, stack, context, line, offset) do
    xp_Name__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Name__1(rest, acc, stack, context, line, offset) do
    xp_Name__2(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Name__2(rest, acc, stack, context, line, offset) do
    case(xp_NameStartChar__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Name__3(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Name__3(rest, acc, stack, context, line, offset) do
    xp_Name__5(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp xp_Name__5(rest, acc, stack, context, line, offset) do
    case(xp_NameChar__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Name__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_Name__4(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Name__4(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_Name__7(rest, acc, stack, context, line, offset)
  end

  defp xp_Name__6(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_Name__5(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_Name__7(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_Name__8(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_Name__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Name__9(rest, [name: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_Name__9(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NCName__0(rest, acc, stack, context, line, offset) do
    xp_NCName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NCName__1(<<":", _::binary>> = rest, acc, stack, context, line, offset) do
    {:error, "did not expect string \":\"", rest, context, line, offset}
  end

  defp xp_NCName__1(rest, acc, stack, context, line, offset) do
    xp_NCName__2(rest, acc, stack, context, line, offset)
  end

  defp xp_NCName__2(rest, acc, stack, context, line, offset) do
    case(xp_Name__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NCName__3(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NCName__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_NCName__4(rest, [NC_name: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_NCName__4(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_LocalPart__0(rest, acc, stack, context, line, offset) do
    xp_LocalPart__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_LocalPart__1(rest, acc, stack, context, line, offset) do
    case(xp_NCName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_LocalPart__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_LocalPart__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_LocalPart__3(
      rest,
      [local_part: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_LocalPart__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Prefix__0(rest, acc, stack, context, line, offset) do
    xp_Prefix__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Prefix__1(rest, acc, stack, context, line, offset) do
    case(xp_NCName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Prefix__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Prefix__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Prefix__3(rest, [prefix: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_Prefix__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_UnprefixedName__0(rest, acc, stack, context, line, offset) do
    xp_UnprefixedName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_UnprefixedName__1(rest, acc, stack, context, line, offset) do
    case(xp_LocalPart__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_UnprefixedName__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_UnprefixedName__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_UnprefixedName__3(
      rest,
      [unprefixed_name: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_UnprefixedName__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_PrefixedName__0(rest, acc, stack, context, line, offset) do
    xp_PrefixedName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PrefixedName__1(rest, acc, stack, context, line, offset) do
    case(xp_Prefix__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrefixedName__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PrefixedName__2(rest, acc, stack, context, line, offset) do
    xp_PrefixedName__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PrefixedName__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrefixedName__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PrefixedName__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PrefixedName__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_PrefixedName__5(<<":", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_PrefixedName__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_PrefixedName__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \":\"", rest, context, line, offset}
  end

  defp xp_PrefixedName__6(rest, acc, stack, context, line, offset) do
    xp_PrefixedName__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PrefixedName__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrefixedName__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PrefixedName__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PrefixedName__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_PrefixedName__9(rest, acc, stack, context, line, offset) do
    case(xp_LocalPart__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrefixedName__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PrefixedName__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_PrefixedName__11(
      rest,
      [prefixed_name: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_PrefixedName__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_QName__0(rest, acc, stack, context, line, offset) do
    xp_QName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QName__1(rest, acc, stack, context, line, offset) do
    xp_QName__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_QName__3(rest, acc, stack, context, line, offset) do
    case(xp_UnprefixedName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QName__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QName__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_QName__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_QName__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_QName__3(rest, [], stack, context, line, offset)
  end

  defp xp_QName__6(rest, acc, stack, context, line, offset) do
    case(xp_PrefixedName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QName__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_QName__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_QName__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_QName__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_QName__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QName__8(rest, [Q_name: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_QName__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_CommentContents__0(rest, acc, stack, context, line, offset) do
    xp_CommentContents__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CommentContents__1(rest, acc, stack, context, line, offset) do
    xp_CommentContents__2(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CommentContents__2(rest, acc, stack, context, line, offset) do
    xp_CommentContents__4(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_CommentContents__4(<<"(:", _::binary>> = rest, acc, stack, context, line, offset) do
    xp_CommentContents__3(rest, acc, stack, context, line, offset)
  end

  defp xp_CommentContents__4(<<":)", _::binary>> = rest, acc, stack, context, line, offset) do
    xp_CommentContents__3(rest, acc, stack, context, line, offset)
  end

  defp xp_CommentContents__4(rest, acc, stack, context, line, offset) do
    xp_CommentContents__5(rest, acc, stack, context, line, offset)
  end

  defp xp_CommentContents__5(rest, acc, stack, context, line, offset) do
    case(xp_Char__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CommentContents__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_CommentContents__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CommentContents__3(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_CommentContents__7(rest, acc, stack, context, line, offset)
  end

  defp xp_CommentContents__6(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_CommentContents__4(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_CommentContents__7(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_CommentContents__8(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_CommentContents__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_CommentContents__9(
      rest,
      [comment_contents: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_CommentContents__9(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Digits__0(rest, acc, stack, context, line, offset) do
    xp_Digits__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Digits__1(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    xp_Digits__2(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_Digits__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected utf8 codepoint in the range '0' to '9'", rest, context, line, offset}
  end

  defp xp_Digits__2(<<x0::utf8, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    xp_Digits__4(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_Digits__2(rest, acc, stack, context, line, offset) do
    xp_Digits__3(rest, acc, stack, context, line, offset)
  end

  defp xp_Digits__4(rest, acc, stack, context, line, offset) do
    xp_Digits__2(rest, acc, stack, context, line, offset)
  end

  defp xp_Digits__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Digits__5(rest, [digits: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_Digits__5(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Comment__0(rest, acc, stack, context, line, offset) do
    xp_Comment__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Comment__1(<<"(:", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Comment__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_Comment__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(:\"", rest, context, line, offset}
  end

  defp xp_Comment__2(rest, acc, stack, context, line, offset) do
    xp_Comment__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Comment__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Comment__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Comment__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Comment__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Comment__5(rest, acc, stack, context, line, offset) do
    xp_Comment__7(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp xp_Comment__7(rest, acc, stack, context, line, offset) do
    xp_Comment__12(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_Comment__9(rest, acc, stack, context, line, offset) do
    case(xp_Comment__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Comment__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_Comment__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Comment__10(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Comment__8(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Comment__11(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_Comment__9(rest, [], stack, context, line, offset)
  end

  defp xp_Comment__12(rest, acc, stack, context, line, offset) do
    case(xp_CommentContents__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Comment__13(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_Comment__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Comment__13(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Comment__8(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Comment__6(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_Comment__14(rest, acc, stack, context, line, offset)
  end

  defp xp_Comment__8(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_Comment__7(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_Comment__14(rest, acc, stack, context, line, offset) do
    xp_Comment__15(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Comment__15(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Comment__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Comment__16(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Comment__17(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Comment__17(<<":)", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Comment__18(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_Comment__17(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \":)\"", rest, context, line, offset}
  end

  defp xp_Comment__18(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Comment__19(rest, [comment: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_Comment__19(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_EscapeApos__0(<<"''", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_EscapeApos__1(rest, [:escape_apos] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_EscapeApos__0(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"''\"", rest, context, line, offset}
  end

  defp xp_EscapeApos__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_EscapeQuot__0(<<"\"\"", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_EscapeQuot__1(rest, [:escape_quot] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_EscapeQuot__0(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"\\\"\\\"\"", rest, context, line, offset}
  end

  defp xp_EscapeQuot__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_BracedURILiteral__0(rest, acc, stack, context, line, offset) do
    xp_BracedURILiteral__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_BracedURILiteral__1(rest, acc, stack, context, line, offset) do
    xp_BracedURILiteral__2(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_BracedURILiteral__2(
         <<"Q", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_BracedURILiteral__3(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_BracedURILiteral__2(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"Q\"", rest, context, line, offset}
  end

  defp xp_BracedURILiteral__3(rest, acc, stack, context, line, offset) do
    xp_BracedURILiteral__4(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_BracedURILiteral__4(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_BracedURILiteral__5(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_BracedURILiteral__5(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_BracedURILiteral__6(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_BracedURILiteral__6(
         <<"{", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_BracedURILiteral__7(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_BracedURILiteral__6(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"{\"", rest, context, line, offset}
  end

  defp xp_BracedURILiteral__7(rest, acc, stack, context, line, offset) do
    xp_BracedURILiteral__8(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_BracedURILiteral__8(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_BracedURILiteral__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_BracedURILiteral__9(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_BracedURILiteral__10(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_BracedURILiteral__10(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 !== 123 and x0 !== 125 do
    xp_BracedURILiteral__12(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case(x0) do
          10 ->
            {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}

          _ ->
            line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_BracedURILiteral__10(rest, acc, stack, context, line, offset) do
    xp_BracedURILiteral__11(rest, acc, stack, context, line, offset)
  end

  defp xp_BracedURILiteral__12(rest, acc, stack, context, line, offset) do
    xp_BracedURILiteral__10(rest, acc, stack, context, line, offset)
  end

  defp xp_BracedURILiteral__11(rest, acc, stack, context, line, offset) do
    xp_BracedURILiteral__13(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_BracedURILiteral__13(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_BracedURILiteral__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_BracedURILiteral__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_BracedURILiteral__15(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_BracedURILiteral__15(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_BracedURILiteral__16(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_BracedURILiteral__16(
         <<"}", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_BracedURILiteral__17(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_BracedURILiteral__16(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"}\"", rest, context, line, offset}
  end

  defp xp_BracedURILiteral__17(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_BracedURILiteral__18(
      rest,
      [braced_uri_literal: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_BracedURILiteral__18(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_URIQualifiedName__0(rest, acc, stack, context, line, offset) do
    xp_URIQualifiedName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_URIQualifiedName__1(rest, acc, stack, context, line, offset) do
    case(xp_BracedURILiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_URIQualifiedName__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_URIQualifiedName__2(rest, acc, stack, context, line, offset) do
    case(xp_NCName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_URIQualifiedName__3(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_URIQualifiedName__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_URIQualifiedName__4(
      rest,
      [URI_qualified_name: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_URIQualifiedName__4(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_StringLiteral__0(rest, acc, stack, context, line, offset) do
    xp_StringLiteral__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_StringLiteral__1(rest, acc, stack, context, line, offset) do
    xp_StringLiteral__16(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_StringLiteral__3(<<"'", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_StringLiteral__4(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_StringLiteral__3(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"\\\"\", followed by xp_EscapeQuot or utf8 codepoint, and not equal to '\"', followed by string \"\\\"\" or string \"'\", followed by xp_EscapeQuot or utf8 codepoint, and not equal to '\\'', followed by string \"'\"",
     rest, context, line, offset}
  end

  defp xp_StringLiteral__4(rest, acc, stack, context, line, offset) do
    xp_StringLiteral__6(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_StringLiteral__6(rest, acc, stack, context, line, offset) do
    xp_StringLiteral__11(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_StringLiteral__8(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 !== 39 do
    xp_StringLiteral__9(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case(x0) do
          10 ->
            {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}

          _ ->
            line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_StringLiteral__8(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    xp_StringLiteral__5(rest, acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__9(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_StringLiteral__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__10(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_StringLiteral__8(rest, [], stack, context, line, offset)
  end

  defp xp_StringLiteral__11(rest, acc, stack, context, line, offset) do
    case(xp_EscapeQuot__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_StringLiteral__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_StringLiteral__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_StringLiteral__12(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_StringLiteral__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__5(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_StringLiteral__13(rest, acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__7(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_StringLiteral__6(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_StringLiteral__13(<<"'", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_StringLiteral__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_StringLiteral__13(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"\\\"\", followed by xp_EscapeQuot or utf8 codepoint, and not equal to '\"', followed by string \"\\\"\" or string \"'\", followed by xp_EscapeQuot or utf8 codepoint, and not equal to '\\'', followed by string \"'\"",
     rest, context, line, offset}
  end

  defp xp_StringLiteral__14(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_StringLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__15(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_StringLiteral__3(rest, [], stack, context, line, offset)
  end

  defp xp_StringLiteral__16(<<"\"", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_StringLiteral__17(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_StringLiteral__16(rest, acc, stack, context, line, offset) do
    xp_StringLiteral__15(rest, acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__17(rest, acc, stack, context, line, offset) do
    xp_StringLiteral__19(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_StringLiteral__19(rest, acc, stack, context, line, offset) do
    xp_StringLiteral__24(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_StringLiteral__21(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 !== 34 do
    xp_StringLiteral__22(
      rest,
      [x0] ++ acc,
      stack,
      context,
      (
        line = comb__line

        case(x0) do
          10 ->
            {elem(line, 0) + 1, comb__offset + byte_size(<<x0::utf8>>)}

          _ ->
            line
        end
      ),
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_StringLiteral__21(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    xp_StringLiteral__18(rest, acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__22(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_StringLiteral__20(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__23(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_StringLiteral__21(rest, [], stack, context, line, offset)
  end

  defp xp_StringLiteral__24(rest, acc, stack, context, line, offset) do
    case(xp_EscapeQuot__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_StringLiteral__25(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_StringLiteral__23(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_StringLiteral__25(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_StringLiteral__20(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__18(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_StringLiteral__26(rest, acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__20(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_StringLiteral__19(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_StringLiteral__26(<<"\"", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_StringLiteral__27(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_StringLiteral__26(rest, acc, stack, context, line, offset) do
    xp_StringLiteral__15(rest, acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__27(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_StringLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_StringLiteral__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_StringLiteral__28(
      rest,
      [string_literal: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_StringLiteral__28(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_DoubleLiteral__0(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DoubleLiteral__1(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__19(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_DoubleLiteral__3(rest, acc, stack, context, line, offset) do
    case(xp_Digits__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DoubleLiteral__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DoubleLiteral__4(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DoubleLiteral__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DoubleLiteral__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DoubleLiteral__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DoubleLiteral__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__7(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__11(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_DoubleLiteral__9(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DoubleLiteral__8(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__10(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_DoubleLiteral__9(rest, [], stack, context, line, offset)
  end

  defp xp_DoubleLiteral__11(<<".", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_DoubleLiteral__12(rest, [:decimal] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_DoubleLiteral__11(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__10(rest, acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__12(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__13(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DoubleLiteral__13(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DoubleLiteral__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_DoubleLiteral__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_DoubleLiteral__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DoubleLiteral__15(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__15(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 do
    xp_DoubleLiteral__17(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_DoubleLiteral__15(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__16(rest, acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__17(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__15(rest, acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__16(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DoubleLiteral__8(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DoubleLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__18(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_DoubleLiteral__3(rest, [], stack, context, line, offset)
  end

  defp xp_DoubleLiteral__19(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__20(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DoubleLiteral__20(<<".", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_DoubleLiteral__21(rest, acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_DoubleLiteral__20(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_DoubleLiteral__18(rest, acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__21(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__22(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DoubleLiteral__22(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DoubleLiteral__23(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_DoubleLiteral__18(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_DoubleLiteral__23(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DoubleLiteral__24(rest, acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__24(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DoubleLiteral__25(rest, [:decimal] ++ acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__25(rest, acc, stack, context, line, offset) do
    case(xp_Digits__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DoubleLiteral__26(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_DoubleLiteral__18(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_DoubleLiteral__26(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DoubleLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__2(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__27(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DoubleLiteral__27(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DoubleLiteral__28(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DoubleLiteral__28(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DoubleLiteral__29(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__29(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 === 101 or x0 === 69 do
    xp_DoubleLiteral__30(
      rest,
      [:exponential] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_DoubleLiteral__29(rest, _acc, _stack, context, line, offset) do
    {:error, "expected utf8 codepoint equal to 'e' or equal to 'E'", rest, context, line, offset}
  end

  defp xp_DoubleLiteral__30(rest, acc, stack, context, line, offset) do
    xp_DoubleLiteral__31(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DoubleLiteral__31(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DoubleLiteral__32(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DoubleLiteral__32(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DoubleLiteral__33(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_DoubleLiteral__33(rest, acc, stack, context, line, offset) do
    case(xp_Digits__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DoubleLiteral__34(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DoubleLiteral__34(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_DoubleLiteral__35(
      rest,
      [double_literal: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_DoubleLiteral__35(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_DecimalLiteral__0(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DecimalLiteral__1(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__17(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_DecimalLiteral__3(rest, acc, stack, context, line, offset) do
    case(xp_Digits__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DecimalLiteral__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DecimalLiteral__4(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DecimalLiteral__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DecimalLiteral__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DecimalLiteral__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DecimalLiteral__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__7(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__8(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DecimalLiteral__8(<<".", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_DecimalLiteral__9(rest, acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_DecimalLiteral__8(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \".\", followed by xp_S, followed by xp_Digits or xp_Digits, followed by xp_S, followed by string \".\", followed by xp_S, followed by utf8 codepoint in the range '0' to '9'",
     rest, context, line, offset}
  end

  defp xp_DecimalLiteral__9(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__10(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DecimalLiteral__10(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DecimalLiteral__11(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DecimalLiteral__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DecimalLiteral__12(rest, acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DecimalLiteral__13(rest, [:decimal] ++ acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__13(
         <<x0::utf8, rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 do
    xp_DecimalLiteral__15(
      rest,
      [x0] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + byte_size(<<x0::utf8>>)
    )
  end

  defp xp_DecimalLiteral__13(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__14(rest, acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__15(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__13(rest, acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__14(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DecimalLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__16(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_DecimalLiteral__3(rest, [], stack, context, line, offset)
  end

  defp xp_DecimalLiteral__17(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__18(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DecimalLiteral__18(<<".", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_DecimalLiteral__19(rest, acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_DecimalLiteral__18(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_DecimalLiteral__16(rest, acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__19(rest, acc, stack, context, line, offset) do
    xp_DecimalLiteral__20(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DecimalLiteral__20(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DecimalLiteral__21(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_DecimalLiteral__16(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_DecimalLiteral__21(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DecimalLiteral__22(rest, acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__22(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DecimalLiteral__23(rest, [:decimal] ++ acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__23(rest, acc, stack, context, line, offset) do
    case(xp_Digits__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DecimalLiteral__24(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_DecimalLiteral__16(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_DecimalLiteral__24(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DecimalLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DecimalLiteral__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_DecimalLiteral__25(
      rest,
      [decimal_literal: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_DecimalLiteral__25(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_IntegerLiteral__0(rest, acc, stack, context, line, offset) do
    xp_IntegerLiteral__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IntegerLiteral__1(rest, acc, stack, context, line, offset) do
    case(xp_Digits__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IntegerLiteral__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IntegerLiteral__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_IntegerLiteral__3(
      rest,
      [integer_literal: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_IntegerLiteral__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_EQName__0(rest, acc, stack, context, line, offset) do
    xp_EQName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_EQName__1(rest, acc, stack, context, line, offset) do
    xp_EQName__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_EQName__3(rest, acc, stack, context, line, offset) do
    case(xp_URIQualifiedName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_EQName__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_EQName__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_EQName__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_EQName__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_EQName__3(rest, [], stack, context, line, offset)
  end

  defp xp_EQName__6(rest, acc, stack, context, line, offset) do
    case(xp_QName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_EQName__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_EQName__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_EQName__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_EQName__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_EQName__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_EQName__8(rest, [EQ_name: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_EQName__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ParenthesizedItemType__0(rest, acc, stack, context, line, offset) do
    xp_ParenthesizedItemType__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParenthesizedItemType__1(
         <<"(", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ParenthesizedItemType__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ParenthesizedItemType__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_ParenthesizedItemType__2(rest, acc, stack, context, line, offset) do
    xp_ParenthesizedItemType__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParenthesizedItemType__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParenthesizedItemType__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ParenthesizedItemType__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ParenthesizedItemType__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ParenthesizedItemType__5(rest, acc, stack, context, line, offset) do
    case(xp_ItemType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParenthesizedItemType__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ParenthesizedItemType__6(rest, acc, stack, context, line, offset) do
    xp_ParenthesizedItemType__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParenthesizedItemType__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParenthesizedItemType__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ParenthesizedItemType__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ParenthesizedItemType__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ParenthesizedItemType__9(
         <<")", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ParenthesizedItemType__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ParenthesizedItemType__9(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_ParenthesizedItemType__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ParenthesizedItemType__11(
      rest,
      [parenthesized_item_type: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ParenthesizedItemType__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_TypedFunctionTest__0(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypedFunctionTest__1(
         <<"function", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_TypedFunctionTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp xp_TypedFunctionTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"function\"", rest, context, line, offset}
  end

  defp xp_TypedFunctionTest__2(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypedFunctionTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TypedFunctionTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TypedFunctionTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__5(
         <<"(", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_TypedFunctionTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_TypedFunctionTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_TypedFunctionTest__6(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__10(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_TypedFunctionTest__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_TypedFunctionTest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__9(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_TypedFunctionTest__8(rest, [], stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__10(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypedFunctionTest__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_TypedFunctionTest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TypedFunctionTest__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TypedFunctionTest__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__13(rest, acc, stack, context, line, offset) do
    case(xp_SequenceType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_TypedFunctionTest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TypedFunctionTest__14(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__16(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_TypedFunctionTest__16(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__17(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypedFunctionTest__17(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__18(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_TypedFunctionTest__15(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TypedFunctionTest__18(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TypedFunctionTest__19(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__19(
         <<",", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_TypedFunctionTest__20(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_TypedFunctionTest__19(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__15(rest, acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__20(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__21(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypedFunctionTest__21(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__22(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_TypedFunctionTest__15(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TypedFunctionTest__22(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TypedFunctionTest__23(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__23(rest, acc, stack, context, line, offset) do
    case(xp_SequenceType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__24(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_TypedFunctionTest__15(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TypedFunctionTest__15(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_TypedFunctionTest__25(rest, acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__24(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_TypedFunctionTest__16(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_TypedFunctionTest__25(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_TypedFunctionTest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__7(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__26(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypedFunctionTest__26(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__27(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TypedFunctionTest__27(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TypedFunctionTest__28(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__28(
         <<"as", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_TypedFunctionTest__29(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_TypedFunctionTest__28(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"as\"", rest, context, line, offset}
  end

  defp xp_TypedFunctionTest__29(rest, acc, stack, context, line, offset) do
    xp_TypedFunctionTest__30(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypedFunctionTest__30(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__31(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TypedFunctionTest__31(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TypedFunctionTest__32(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TypedFunctionTest__32(rest, acc, stack, context, line, offset) do
    case(xp_SequenceType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypedFunctionTest__33(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TypedFunctionTest__33(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_TypedFunctionTest__34(
      rest,
      [typed_function_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_TypedFunctionTest__34(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AnyFunctionTest__0(rest, acc, stack, context, line, offset) do
    xp_AnyFunctionTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AnyFunctionTest__1(
         <<"function", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_AnyFunctionTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp xp_AnyFunctionTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"function\"", rest, context, line, offset}
  end

  defp xp_AnyFunctionTest__2(rest, acc, stack, context, line, offset) do
    xp_AnyFunctionTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AnyFunctionTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AnyFunctionTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AnyFunctionTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AnyFunctionTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AnyFunctionTest__5(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AnyFunctionTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AnyFunctionTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_AnyFunctionTest__6(rest, acc, stack, context, line, offset) do
    xp_AnyFunctionTest__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AnyFunctionTest__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AnyFunctionTest__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AnyFunctionTest__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AnyFunctionTest__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AnyFunctionTest__9(<<"*", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AnyFunctionTest__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AnyFunctionTest__9(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"*\"", rest, context, line, offset}
  end

  defp xp_AnyFunctionTest__10(rest, acc, stack, context, line, offset) do
    xp_AnyFunctionTest__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AnyFunctionTest__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AnyFunctionTest__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AnyFunctionTest__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AnyFunctionTest__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AnyFunctionTest__13(
         <<")", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_AnyFunctionTest__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AnyFunctionTest__13(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_AnyFunctionTest__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AnyFunctionTest__15(
      rest,
      [any_function_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AnyFunctionTest__15(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_FunctionTest__0(rest, acc, stack, context, line, offset) do
    xp_FunctionTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_FunctionTest__1(rest, acc, stack, context, line, offset) do
    xp_FunctionTest__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_FunctionTest__3(rest, acc, stack, context, line, offset) do
    case(xp_TypedFunctionTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_FunctionTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_FunctionTest__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_FunctionTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_FunctionTest__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_FunctionTest__3(rest, [], stack, context, line, offset)
  end

  defp xp_FunctionTest__6(rest, acc, stack, context, line, offset) do
    case(xp_AnyFunctionTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_FunctionTest__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_FunctionTest__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_FunctionTest__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_FunctionTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_FunctionTest__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_FunctionTest__8(
      rest,
      [function_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_FunctionTest__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_TypeName__0(rest, acc, stack, context, line, offset) do
    xp_TypeName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypeName__1(rest, acc, stack, context, line, offset) do
    case(xp_TypeName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypeName__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TypeName__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_TypeName__3(
      rest,
      [type_name: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_TypeName__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SimpleTypeName__0(rest, acc, stack, context, line, offset) do
    xp_SimpleTypeName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleTypeName__1(rest, acc, stack, context, line, offset) do
    case(xp_TypeName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleTypeName__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleTypeName__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SimpleTypeName__3(
      rest,
      [simple_type_name: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SimpleTypeName__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ElementName__0(rest, acc, stack, context, line, offset) do
    xp_ElementName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementName__1(rest, acc, stack, context, line, offset) do
    case(xp_EQName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementName__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ElementName__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ElementName__3(
      rest,
      [element_name: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ElementName__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AttributeName__0(rest, acc, stack, context, line, offset) do
    xp_AttributeName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeName__1(rest, acc, stack, context, line, offset) do
    case(xp_EQName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeName__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AttributeName__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AttributeName__3(
      rest,
      [attribute_name: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AttributeName__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ElementDeclaration__0(rest, acc, stack, context, line, offset) do
    xp_ElementDeclaration__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementDeclaration__1(rest, acc, stack, context, line, offset) do
    case(xp_ElementName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementDeclaration__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ElementDeclaration__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ElementDeclaration__3(
      rest,
      [element_declaration: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ElementDeclaration__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SchemaElementTest__0(rest, acc, stack, context, line, offset) do
    xp_SchemaElementTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SchemaElementTest__1(
         <<"schema-element", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SchemaElementTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 14)
  end

  defp xp_SchemaElementTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"schema-element\"", rest, context, line, offset}
  end

  defp xp_SchemaElementTest__2(rest, acc, stack, context, line, offset) do
    xp_SchemaElementTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SchemaElementTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SchemaElementTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SchemaElementTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SchemaElementTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SchemaElementTest__5(
         <<"(", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SchemaElementTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SchemaElementTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_SchemaElementTest__6(rest, acc, stack, context, line, offset) do
    xp_SchemaElementTest__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SchemaElementTest__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SchemaElementTest__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SchemaElementTest__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SchemaElementTest__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SchemaElementTest__9(rest, acc, stack, context, line, offset) do
    case(xp_ElementDeclaration__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SchemaElementTest__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SchemaElementTest__10(rest, acc, stack, context, line, offset) do
    xp_SchemaElementTest__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SchemaElementTest__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SchemaElementTest__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SchemaElementTest__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SchemaElementTest__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SchemaElementTest__13(
         <<")", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SchemaElementTest__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SchemaElementTest__13(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_SchemaElementTest__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SchemaElementTest__15(
      rest,
      [schema_element_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SchemaElementTest__15(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ElementNameOrWildcard__0(rest, acc, stack, context, line, offset) do
    xp_ElementNameOrWildcard__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementNameOrWildcard__1(rest, acc, stack, context, line, offset) do
    xp_ElementNameOrWildcard__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ElementNameOrWildcard__3(
         <<"*", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ElementNameOrWildcard__4(
      rest,
      [:wildcard] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp xp_ElementNameOrWildcard__3(rest, _acc, _stack, context, line, offset) do
    {:error, "expected xp_ElementName or string \"*\"", rest, context, line, offset}
  end

  defp xp_ElementNameOrWildcard__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ElementNameOrWildcard__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ElementNameOrWildcard__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ElementNameOrWildcard__3(rest, [], stack, context, line, offset)
  end

  defp xp_ElementNameOrWildcard__6(rest, acc, stack, context, line, offset) do
    case(xp_ElementName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementNameOrWildcard__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ElementNameOrWildcard__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ElementNameOrWildcard__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ElementNameOrWildcard__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ElementNameOrWildcard__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ElementNameOrWildcard__8(
      rest,
      [element_name_or_wildcard: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ElementNameOrWildcard__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ElementTest__0(rest, acc, stack, context, line, offset) do
    xp_ElementTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementTest__1(
         <<"element", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ElementTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp xp_ElementTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"element\"", rest, context, line, offset}
  end

  defp xp_ElementTest__2(rest, acc, stack, context, line, offset) do
    xp_ElementTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ElementTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ElementTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ElementTest__5(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ElementTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ElementTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_ElementTest__6(rest, acc, stack, context, line, offset) do
    xp_ElementTest__10(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ElementTest__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ElementTest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ElementTest__9(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ElementTest__8(rest, [], stack, context, line, offset)
  end

  defp xp_ElementTest__10(rest, acc, stack, context, line, offset) do
    xp_ElementTest__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementTest__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementTest__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ElementTest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ElementTest__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ElementTest__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ElementTest__13(rest, acc, stack, context, line, offset) do
    case(xp_ElementNameOrWildcard__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementTest__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ElementTest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ElementTest__14(rest, acc, stack, context, line, offset) do
    xp_ElementTest__18(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ElementTest__16(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ElementTest__15(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ElementTest__17(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ElementTest__16(rest, [], stack, context, line, offset)
  end

  defp xp_ElementTest__18(rest, acc, stack, context, line, offset) do
    xp_ElementTest__19(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementTest__19(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementTest__20(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ElementTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ElementTest__20(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ElementTest__21(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ElementTest__21(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ElementTest__22(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ElementTest__21(rest, acc, stack, context, line, offset) do
    xp_ElementTest__17(rest, acc, stack, context, line, offset)
  end

  defp xp_ElementTest__22(rest, acc, stack, context, line, offset) do
    xp_ElementTest__23(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementTest__23(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementTest__24(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ElementTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ElementTest__24(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ElementTest__25(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ElementTest__25(rest, acc, stack, context, line, offset) do
    case(xp_TypeName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementTest__26(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ElementTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ElementTest__26(rest, acc, stack, context, line, offset) do
    xp_ElementTest__27(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementTest__27(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementTest__28(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ElementTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ElementTest__28(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ElementTest__29(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ElementTest__29(<<"?", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ElementTest__30(rest, [:optional] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ElementTest__29(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ElementTest__30(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp xp_ElementTest__30(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ElementTest__15(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ElementTest__15(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ElementTest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ElementTest__7(rest, acc, stack, context, line, offset) do
    xp_ElementTest__31(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ElementTest__31(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ElementTest__32(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ElementTest__32(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ElementTest__33(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ElementTest__33(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ElementTest__34(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ElementTest__33(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_ElementTest__34(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ElementTest__35(
      rest,
      [element_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ElementTest__35(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AttributeDeclaration__0(rest, acc, stack, context, line, offset) do
    xp_AttributeDeclaration__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeDeclaration__1(rest, acc, stack, context, line, offset) do
    case(xp_AttributeName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeDeclaration__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AttributeDeclaration__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AttributeDeclaration__3(
      rest,
      [attribute_declaration: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AttributeDeclaration__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SchemaAttributeTest__0(rest, acc, stack, context, line, offset) do
    xp_SchemaAttributeTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SchemaAttributeTest__1(
         <<"schema-attribute", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SchemaAttributeTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 16)
  end

  defp xp_SchemaAttributeTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"schema-attribute\"", rest, context, line, offset}
  end

  defp xp_SchemaAttributeTest__2(rest, acc, stack, context, line, offset) do
    xp_SchemaAttributeTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SchemaAttributeTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SchemaAttributeTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SchemaAttributeTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SchemaAttributeTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SchemaAttributeTest__5(
         <<"(", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SchemaAttributeTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SchemaAttributeTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_SchemaAttributeTest__6(rest, acc, stack, context, line, offset) do
    xp_SchemaAttributeTest__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SchemaAttributeTest__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SchemaAttributeTest__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SchemaAttributeTest__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SchemaAttributeTest__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SchemaAttributeTest__9(rest, acc, stack, context, line, offset) do
    case(xp_AttributeDeclaration__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SchemaAttributeTest__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SchemaAttributeTest__10(rest, acc, stack, context, line, offset) do
    xp_SchemaAttributeTest__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SchemaAttributeTest__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SchemaAttributeTest__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SchemaAttributeTest__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SchemaAttributeTest__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SchemaAttributeTest__13(
         <<")", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SchemaAttributeTest__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SchemaAttributeTest__13(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_SchemaAttributeTest__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SchemaAttributeTest__15(
      rest,
      [schema_attribute_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SchemaAttributeTest__15(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AttribNameOrWildcard__0(rest, acc, stack, context, line, offset) do
    xp_AttribNameOrWildcard__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttribNameOrWildcard__1(rest, acc, stack, context, line, offset) do
    xp_AttribNameOrWildcard__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_AttribNameOrWildcard__3(
         <<"*", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_AttribNameOrWildcard__4(
      rest,
      [:wildcard] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp xp_AttribNameOrWildcard__3(rest, _acc, _stack, context, line, offset) do
    {:error, "expected xp_AttributeName or string \"*\"", rest, context, line, offset}
  end

  defp xp_AttribNameOrWildcard__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AttribNameOrWildcard__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AttribNameOrWildcard__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_AttribNameOrWildcard__3(rest, [], stack, context, line, offset)
  end

  defp xp_AttribNameOrWildcard__6(rest, acc, stack, context, line, offset) do
    case(xp_AttributeName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttribNameOrWildcard__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_AttribNameOrWildcard__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AttribNameOrWildcard__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AttribNameOrWildcard__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AttribNameOrWildcard__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AttribNameOrWildcard__8(
      rest,
      [attrib_name_or_wildcard: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AttribNameOrWildcard__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AttributeTest__0(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeTest__1(
         <<"attribute", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_AttributeTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp xp_AttributeTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"attribute\"", rest, context, line, offset}
  end

  defp xp_AttributeTest__2(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AttributeTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AttributeTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__5(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AttributeTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AttributeTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_AttributeTest__6(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__10(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_AttributeTest__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AttributeTest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__9(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_AttributeTest__8(rest, [], stack, context, line, offset)
  end

  defp xp_AttributeTest__10(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeTest__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeTest__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_AttributeTest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AttributeTest__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AttributeTest__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__13(rest, acc, stack, context, line, offset) do
    case(xp_AttribNameOrWildcard__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeTest__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_AttributeTest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AttributeTest__14(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__18(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_AttributeTest__16(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AttributeTest__15(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__17(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_AttributeTest__16(rest, [], stack, context, line, offset)
  end

  defp xp_AttributeTest__18(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__19(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeTest__19(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeTest__20(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_AttributeTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AttributeTest__20(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AttributeTest__21(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__21(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__22(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeTest__22(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AttributeTest__23(rest, acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AttributeTest__22(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_AttributeTest__17(rest, acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__23(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__24(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeTest__24(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeTest__25(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_AttributeTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AttributeTest__25(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AttributeTest__26(rest, acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__26(rest, acc, stack, context, line, offset) do
    case(xp_TypeName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeTest__27(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_AttributeTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AttributeTest__27(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AttributeTest__28(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__28(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AttributeTest__15(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__15(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AttributeTest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__7(rest, acc, stack, context, line, offset) do
    xp_AttributeTest__29(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AttributeTest__29(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AttributeTest__30(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AttributeTest__30(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AttributeTest__31(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AttributeTest__31(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AttributeTest__32(
      rest,
      [attribute_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AttributeTest__32(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_PITest__0(rest, acc, stack, context, line, offset) do
    xp_PITest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PITest__1(
         <<"processing-instruction", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_PITest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 22)
  end

  defp xp_PITest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"processing-instruction\"", rest, context, line, offset}
  end

  defp xp_PITest__2(rest, acc, stack, context, line, offset) do
    xp_PITest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PITest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PITest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PITest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PITest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_PITest__5(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_PITest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_PITest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_PITest__6(rest, acc, stack, context, line, offset) do
    xp_PITest__10(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_PITest__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PITest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PITest__9(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PITest__8(rest, [], stack, context, line, offset)
  end

  defp xp_PITest__10(rest, acc, stack, context, line, offset) do
    xp_PITest__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PITest__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PITest__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_PITest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PITest__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PITest__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_PITest__13(rest, acc, stack, context, line, offset) do
    xp_PITest__18(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_PITest__15(rest, acc, stack, context, line, offset) do
    case(xp_StringLiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PITest__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_PITest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PITest__16(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PITest__14(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PITest__17(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PITest__15(rest, [], stack, context, line, offset)
  end

  defp xp_PITest__18(rest, acc, stack, context, line, offset) do
    case(xp_NCName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PITest__19(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PITest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PITest__19(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PITest__14(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PITest__14(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PITest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PITest__7(rest, acc, stack, context, line, offset) do
    xp_PITest__20(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PITest__20(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PITest__21(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PITest__21(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PITest__22(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_PITest__22(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_PITest__23(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_PITest__22(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_PITest__23(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PITest__24(rest, [pi_test: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_PITest__24(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NamespaceNodeTest__0(rest, acc, stack, context, line, offset) do
    xp_NamespaceNodeTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NamespaceNodeTest__1(
         <<"namespace-node", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_NamespaceNodeTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 14)
  end

  defp xp_NamespaceNodeTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"namespace-node\"", rest, context, line, offset}
  end

  defp xp_NamespaceNodeTest__2(rest, acc, stack, context, line, offset) do
    xp_NamespaceNodeTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NamespaceNodeTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NamespaceNodeTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NamespaceNodeTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_NamespaceNodeTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_NamespaceNodeTest__5(
         <<"(", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_NamespaceNodeTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_NamespaceNodeTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_NamespaceNodeTest__6(rest, acc, stack, context, line, offset) do
    xp_NamespaceNodeTest__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NamespaceNodeTest__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NamespaceNodeTest__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NamespaceNodeTest__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_NamespaceNodeTest__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_NamespaceNodeTest__9(
         <<")", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_NamespaceNodeTest__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_NamespaceNodeTest__9(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_NamespaceNodeTest__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_NamespaceNodeTest__11(
      rest,
      [namespace_node_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_NamespaceNodeTest__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_CommentTest__0(rest, acc, stack, context, line, offset) do
    xp_CommentTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CommentTest__1(
         <<"comment", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_CommentTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp xp_CommentTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"comment\"", rest, context, line, offset}
  end

  defp xp_CommentTest__2(rest, acc, stack, context, line, offset) do
    xp_CommentTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CommentTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CommentTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_CommentTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_CommentTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_CommentTest__5(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_CommentTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_CommentTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_CommentTest__6(rest, acc, stack, context, line, offset) do
    xp_CommentTest__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CommentTest__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CommentTest__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_CommentTest__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_CommentTest__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_CommentTest__9(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_CommentTest__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_CommentTest__9(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_CommentTest__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_CommentTest__11(
      rest,
      [comment_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_CommentTest__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_TextTest__0(rest, acc, stack, context, line, offset) do
    xp_TextTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TextTest__1(<<"text", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_TextTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_TextTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"text\"", rest, context, line, offset}
  end

  defp xp_TextTest__2(rest, acc, stack, context, line, offset) do
    xp_TextTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TextTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TextTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TextTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TextTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TextTest__5(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_TextTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_TextTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_TextTest__6(rest, acc, stack, context, line, offset) do
    xp_TextTest__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TextTest__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TextTest__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TextTest__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TextTest__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TextTest__9(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_TextTest__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_TextTest__9(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_TextTest__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_TextTest__11(
      rest,
      [text_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_TextTest__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_DocumentTest__0(rest, acc, stack, context, line, offset) do
    xp_DocumentTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DocumentTest__1(
         <<"document-node", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_DocumentTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 13)
  end

  defp xp_DocumentTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"document-node\"", rest, context, line, offset}
  end

  defp xp_DocumentTest__2(rest, acc, stack, context, line, offset) do
    xp_DocumentTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DocumentTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DocumentTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DocumentTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DocumentTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_DocumentTest__5(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_DocumentTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_DocumentTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_DocumentTest__6(rest, acc, stack, context, line, offset) do
    xp_DocumentTest__10(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_DocumentTest__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DocumentTest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DocumentTest__9(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_DocumentTest__8(rest, [], stack, context, line, offset)
  end

  defp xp_DocumentTest__10(rest, acc, stack, context, line, offset) do
    xp_DocumentTest__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DocumentTest__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DocumentTest__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_DocumentTest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_DocumentTest__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DocumentTest__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_DocumentTest__13(rest, acc, stack, context, line, offset) do
    xp_DocumentTest__18(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_DocumentTest__15(rest, acc, stack, context, line, offset) do
    case(xp_SchemaElementTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DocumentTest__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_DocumentTest__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_DocumentTest__16(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DocumentTest__14(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DocumentTest__17(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_DocumentTest__15(rest, [], stack, context, line, offset)
  end

  defp xp_DocumentTest__18(rest, acc, stack, context, line, offset) do
    case(xp_ElementTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DocumentTest__19(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_DocumentTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_DocumentTest__19(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DocumentTest__14(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DocumentTest__14(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_DocumentTest__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_DocumentTest__7(rest, acc, stack, context, line, offset) do
    xp_DocumentTest__20(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_DocumentTest__20(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_DocumentTest__21(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_DocumentTest__21(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_DocumentTest__22(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_DocumentTest__22(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_DocumentTest__23(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_DocumentTest__22(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_DocumentTest__23(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_DocumentTest__24(
      rest,
      [document_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_DocumentTest__24(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AnyKindTest__0(rest, acc, stack, context, line, offset) do
    xp_AnyKindTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AnyKindTest__1(<<"node", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AnyKindTest__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_AnyKindTest__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"node\"", rest, context, line, offset}
  end

  defp xp_AnyKindTest__2(rest, acc, stack, context, line, offset) do
    xp_AnyKindTest__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AnyKindTest__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AnyKindTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AnyKindTest__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AnyKindTest__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AnyKindTest__5(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AnyKindTest__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AnyKindTest__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_AnyKindTest__6(rest, acc, stack, context, line, offset) do
    xp_AnyKindTest__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AnyKindTest__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AnyKindTest__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AnyKindTest__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AnyKindTest__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AnyKindTest__9(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AnyKindTest__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AnyKindTest__9(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_AnyKindTest__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AnyKindTest__11(
      rest,
      [any_kind_tag: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AnyKindTest__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_KindTest__0(rest, acc, stack, context, line, offset) do
    xp_KindTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_KindTest__1(rest, acc, stack, context, line, offset) do
    xp_KindTest__30(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_KindTest__3(rest, acc, stack, context, line, offset) do
    case(xp_AnyKindTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_KindTest__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__3(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__6(rest, acc, stack, context, line, offset) do
    case(xp_NamespaceNodeTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__8(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__6(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__9(rest, acc, stack, context, line, offset) do
    case(xp_TextTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__10(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__11(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__9(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__12(rest, acc, stack, context, line, offset) do
    case(xp_CommentTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__13(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__13(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__14(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__12(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__15(rest, acc, stack, context, line, offset) do
    case(xp_PITest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__14(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__16(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__17(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__15(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__18(rest, acc, stack, context, line, offset) do
    case(xp_SchemaAttributeTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__19(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__19(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__20(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__18(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__21(rest, acc, stack, context, line, offset) do
    case(xp_SchemaElementTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__22(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__20(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__22(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__23(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__21(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__24(rest, acc, stack, context, line, offset) do
    case(xp_AttributeTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__25(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__23(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__25(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__26(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__24(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__27(rest, acc, stack, context, line, offset) do
    case(xp_ElementTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__28(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__26(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__28(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__29(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_KindTest__27(rest, [], stack, context, line, offset)
  end

  defp xp_KindTest__30(rest, acc, stack, context, line, offset) do
    case(xp_DocumentTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_KindTest__31(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_KindTest__29(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_KindTest__31(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_KindTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_KindTest__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_KindTest__32(
      rest,
      [kind_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_KindTest__32(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AtomicOrUnionType__0(rest, acc, stack, context, line, offset) do
    xp_AtomicOrUnionType__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AtomicOrUnionType__1(rest, acc, stack, context, line, offset) do
    case(xp_EQName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AtomicOrUnionType__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AtomicOrUnionType__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AtomicOrUnionType__3(
      rest,
      [atomic_or_union_type: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AtomicOrUnionType__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ItemType__0(rest, acc, stack, context, line, offset) do
    xp_ItemType__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ItemType__1(rest, acc, stack, context, line, offset) do
    xp_ItemType__23(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_ItemType__3(rest, acc, stack, context, line, offset) do
    case(xp_ParenthesizedItemType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ItemType__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ItemType__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ItemType__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ItemType__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ItemType__3(rest, [], stack, context, line, offset)
  end

  defp xp_ItemType__6(rest, acc, stack, context, line, offset) do
    case(xp_AtomicOrUnionType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ItemType__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ItemType__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ItemType__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ItemType__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ItemType__8(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ItemType__6(rest, [], stack, context, line, offset)
  end

  defp xp_ItemType__9(rest, acc, stack, context, line, offset) do
    case(xp_FunctionTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ItemType__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ItemType__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ItemType__10(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ItemType__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ItemType__11(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ItemType__9(rest, [], stack, context, line, offset)
  end

  defp xp_ItemType__12(<<"item", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ItemType__13(rest, [:item] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_ItemType__12(rest, acc, stack, context, line, offset) do
    xp_ItemType__11(rest, acc, stack, context, line, offset)
  end

  defp xp_ItemType__13(rest, acc, stack, context, line, offset) do
    xp_ItemType__14(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ItemType__14(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ItemType__15(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ItemType__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ItemType__15(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ItemType__16(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ItemType__16(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ItemType__17(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ItemType__16(rest, acc, stack, context, line, offset) do
    xp_ItemType__11(rest, acc, stack, context, line, offset)
  end

  defp xp_ItemType__17(rest, acc, stack, context, line, offset) do
    xp_ItemType__18(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ItemType__18(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ItemType__19(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ItemType__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ItemType__19(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ItemType__20(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ItemType__20(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ItemType__21(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ItemType__20(rest, acc, stack, context, line, offset) do
    xp_ItemType__11(rest, acc, stack, context, line, offset)
  end

  defp xp_ItemType__21(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ItemType__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ItemType__22(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ItemType__12(rest, [], stack, context, line, offset)
  end

  defp xp_ItemType__23(rest, acc, stack, context, line, offset) do
    case(xp_KindTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ItemType__24(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ItemType__22(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ItemType__24(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ItemType__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ItemType__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ItemType__25(
      rest,
      [item_type: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ItemType__25(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_OccurenceIndicator__0(rest, acc, stack, context, line, offset) do
    xp_OccurenceIndicator__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_OccurenceIndicator__1(
         <<"?", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_OccurenceIndicator__2(rest, [:maybe] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_OccurenceIndicator__1(
         <<"*", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_OccurenceIndicator__2(rest, [:some] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_OccurenceIndicator__1(
         <<"+", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_OccurenceIndicator__2(rest, [:many] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_OccurenceIndicator__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"?\" or string \"*\" or string \"+\"", rest, context, line, offset}
  end

  defp xp_OccurenceIndicator__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_OccurenceIndicator__3(
      rest,
      [occurence_indicator: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_OccurenceIndicator__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SequenceType__0(rest, acc, stack, context, line, offset) do
    xp_SequenceType__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SequenceType__1(rest, acc, stack, context, line, offset) do
    xp_SequenceType__14(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_SequenceType__3(rest, acc, stack, context, line, offset) do
    case(xp_ItemType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SequenceType__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SequenceType__4(rest, acc, stack, context, line, offset) do
    xp_SequenceType__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SequenceType__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SequenceType__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SequenceType__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SequenceType__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SequenceType__7(rest, acc, stack, context, line, offset) do
    xp_SequenceType__11(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_SequenceType__9(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_SequenceType__8(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_SequenceType__10(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_SequenceType__9(rest, [], stack, context, line, offset)
  end

  defp xp_SequenceType__11(rest, acc, stack, context, line, offset) do
    case(xp_OccurenceIndicator__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SequenceType__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_SequenceType__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SequenceType__12(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_SequenceType__8(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_SequenceType__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_SequenceType__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_SequenceType__13(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_SequenceType__3(rest, [], stack, context, line, offset)
  end

  defp xp_SequenceType__14(
         <<"empty-sequence", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SequenceType__15(
      rest,
      [:empty_sequence] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 14
    )
  end

  defp xp_SequenceType__14(rest, acc, stack, context, line, offset) do
    xp_SequenceType__13(rest, acc, stack, context, line, offset)
  end

  defp xp_SequenceType__15(rest, acc, stack, context, line, offset) do
    xp_SequenceType__16(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SequenceType__16(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SequenceType__17(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_SequenceType__13(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SequenceType__17(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SequenceType__18(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SequenceType__18(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_SequenceType__19(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SequenceType__18(rest, acc, stack, context, line, offset) do
    xp_SequenceType__13(rest, acc, stack, context, line, offset)
  end

  defp xp_SequenceType__19(rest, acc, stack, context, line, offset) do
    xp_SequenceType__20(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SequenceType__20(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SequenceType__21(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_SequenceType__13(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SequenceType__21(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SequenceType__22(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SequenceType__22(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_SequenceType__23(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SequenceType__22(rest, acc, stack, context, line, offset) do
    xp_SequenceType__13(rest, acc, stack, context, line, offset)
  end

  defp xp_SequenceType__23(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_SequenceType__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_SequenceType__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SequenceType__24(
      rest,
      [sequence_type: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SequenceType__24(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_TypeDeclaration__0(rest, acc, stack, context, line, offset) do
    xp_TypeDeclaration__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypeDeclaration__1(
         <<"as", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_TypeDeclaration__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_TypeDeclaration__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"as\"", rest, context, line, offset}
  end

  defp xp_TypeDeclaration__2(rest, acc, stack, context, line, offset) do
    xp_TypeDeclaration__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TypeDeclaration__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypeDeclaration__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TypeDeclaration__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TypeDeclaration__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TypeDeclaration__5(rest, acc, stack, context, line, offset) do
    case(xp_SequenceType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TypeDeclaration__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TypeDeclaration__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_TypeDeclaration__7(
      rest,
      [type_declaration: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_TypeDeclaration__7(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SingleType__0(rest, acc, stack, context, line, offset) do
    xp_SingleType__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SingleType__1(rest, acc, stack, context, line, offset) do
    case(xp_SimpleTypeName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SingleType__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SingleType__2(rest, acc, stack, context, line, offset) do
    xp_SingleType__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_SingleType__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_SingleType__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_SingleType__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_SingleType__4(rest, [], stack, context, line, offset)
  end

  defp xp_SingleType__6(rest, acc, stack, context, line, offset) do
    xp_SingleType__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SingleType__7(rest, acc, stack, context, line, offset) do
    xp_SingleType__8(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SingleType__8(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SingleType__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_SingleType__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SingleType__9(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SingleType__10(rest, acc, stack, context, line, offset)
  end

  defp xp_SingleType__10(<<"?", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_SingleType__11(rest, acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SingleType__10(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_SingleType__5(rest, acc, stack, context, line, offset)
  end

  defp xp_SingleType__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SingleType__12(rest, [:optional] ++ acc, stack, context, line, offset)
  end

  defp xp_SingleType__12(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_SingleType__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_SingleType__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SingleType__13(
      rest,
      [single_type: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SingleType__13(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_InlineFunctionExpr__0(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InlineFunctionExpr__1(
         <<"function", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_InlineFunctionExpr__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp xp_InlineFunctionExpr__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"function\"", rest, context, line, offset}
  end

  defp xp_InlineFunctionExpr__2(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InlineFunctionExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_InlineFunctionExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_InlineFunctionExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__5(
         <<"(", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_InlineFunctionExpr__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_InlineFunctionExpr__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_InlineFunctionExpr__6(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InlineFunctionExpr__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_InlineFunctionExpr__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_InlineFunctionExpr__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__9(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__13(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_InlineFunctionExpr__11(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_InlineFunctionExpr__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__12(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_InlineFunctionExpr__11(rest, [], stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__13(rest, acc, stack, context, line, offset) do
    case(xp_ParamList__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_InlineFunctionExpr__12(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_InlineFunctionExpr__14(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__15(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InlineFunctionExpr__15(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_InlineFunctionExpr__12(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_InlineFunctionExpr__16(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_InlineFunctionExpr__17(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__17(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_InlineFunctionExpr__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__10(
         <<")", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_InlineFunctionExpr__18(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_InlineFunctionExpr__10(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_InlineFunctionExpr__18(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__19(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InlineFunctionExpr__19(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__20(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_InlineFunctionExpr__20(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_InlineFunctionExpr__21(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__21(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__25(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_InlineFunctionExpr__23(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_InlineFunctionExpr__22(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__24(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_InlineFunctionExpr__23(rest, [], stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__25(
         <<"as", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_InlineFunctionExpr__26(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_InlineFunctionExpr__25(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__24(rest, acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__26(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__27(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InlineFunctionExpr__27(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__28(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_InlineFunctionExpr__24(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_InlineFunctionExpr__28(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_InlineFunctionExpr__29(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__29(rest, acc, stack, context, line, offset) do
    case(xp_SequenceType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__30(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_InlineFunctionExpr__24(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_InlineFunctionExpr__30(rest, acc, stack, context, line, offset) do
    xp_InlineFunctionExpr__31(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InlineFunctionExpr__31(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__32(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_InlineFunctionExpr__24(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_InlineFunctionExpr__32(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_InlineFunctionExpr__33(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__33(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_InlineFunctionExpr__22(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_InlineFunctionExpr__22(rest, acc, stack, context, line, offset) do
    case(xp_FunctionBody__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InlineFunctionExpr__34(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_InlineFunctionExpr__34(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_InlineFunctionExpr__35(
      rest,
      [inline_function_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_InlineFunctionExpr__35(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NamedFunctionRef__0(rest, acc, stack, context, line, offset) do
    xp_NamedFunctionRef__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NamedFunctionRef__1(rest, acc, stack, context, line, offset) do
    case(xp_EQName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NamedFunctionRef__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NamedFunctionRef__2(rest, acc, stack, context, line, offset) do
    xp_NamedFunctionRef__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NamedFunctionRef__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NamedFunctionRef__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NamedFunctionRef__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_NamedFunctionRef__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_NamedFunctionRef__5(
         <<"#", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_NamedFunctionRef__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_NamedFunctionRef__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"#\"", rest, context, line, offset}
  end

  defp xp_NamedFunctionRef__6(rest, acc, stack, context, line, offset) do
    xp_NamedFunctionRef__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NamedFunctionRef__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NamedFunctionRef__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NamedFunctionRef__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_NamedFunctionRef__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_NamedFunctionRef__9(rest, acc, stack, context, line, offset) do
    case(xp_IntegerLiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NamedFunctionRef__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NamedFunctionRef__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_NamedFunctionRef__11(
      rest,
      [named_function_ref: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_NamedFunctionRef__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_FunctionItemExpr__0(rest, acc, stack, context, line, offset) do
    xp_FunctionItemExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_FunctionItemExpr__1(rest, acc, stack, context, line, offset) do
    xp_FunctionItemExpr__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_FunctionItemExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_InlineFunctionExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_FunctionItemExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_FunctionItemExpr__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_FunctionItemExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_FunctionItemExpr__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_FunctionItemExpr__3(rest, [], stack, context, line, offset)
  end

  defp xp_FunctionItemExpr__6(rest, acc, stack, context, line, offset) do
    case(xp_NamedFunctionRef__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_FunctionItemExpr__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_FunctionItemExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_FunctionItemExpr__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_FunctionItemExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_FunctionItemExpr__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_FunctionItemExpr__8(
      rest,
      [function_item_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_FunctionItemExpr__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ArgumentPlaceholder__0(
         <<"?", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ArgumentPlaceholder__1(
      rest,
      [:argument_placeholder] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp xp_ArgumentPlaceholder__0(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"?\"", rest, context, line, offset}
  end

  defp xp_ArgumentPlaceholder__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Argument__0(rest, acc, stack, context, line, offset) do
    xp_Argument__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Argument__1(rest, acc, stack, context, line, offset) do
    xp_Argument__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_Argument__3(rest, acc, stack, context, line, offset) do
    case(xp_ArgumentPlaceholder__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Argument__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Argument__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Argument__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Argument__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_Argument__3(rest, [], stack, context, line, offset)
  end

  defp xp_Argument__6(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Argument__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_Argument__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Argument__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Argument__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Argument__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_Argument__8(
      rest,
      [argument: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_Argument__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_FunctionCall__0(rest, acc, stack, context, line, offset) do
    xp_FunctionCall__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_FunctionCall__1(rest, acc, stack, context, line, offset) do
    case(xp_EQName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_FunctionCall__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_FunctionCall__2(rest, acc, stack, context, line, offset) do
    xp_FunctionCall__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_FunctionCall__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_FunctionCall__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_FunctionCall__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_FunctionCall__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_FunctionCall__5(rest, acc, stack, context, line, offset) do
    case(xp_ArgumentList__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_FunctionCall__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_FunctionCall__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_FunctionCall__7(
      rest,
      [function_call: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_FunctionCall__7(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ContextItemExpr__0(<<".", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ContextItemExpr__1(
      rest,
      [:context_item_expr] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp xp_ContextItemExpr__0(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \".\"", rest, context, line, offset}
  end

  defp xp_ContextItemExpr__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ParenthesizedExpr__0(rest, acc, stack, context, line, offset) do
    xp_ParenthesizedExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParenthesizedExpr__1(
         <<"(", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ParenthesizedExpr__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ParenthesizedExpr__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_ParenthesizedExpr__2(rest, acc, stack, context, line, offset) do
    xp_ParenthesizedExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParenthesizedExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParenthesizedExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ParenthesizedExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ParenthesizedExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ParenthesizedExpr__5(rest, acc, stack, context, line, offset) do
    xp_ParenthesizedExpr__9(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ParenthesizedExpr__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ParenthesizedExpr__6(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ParenthesizedExpr__8(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ParenthesizedExpr__7(rest, [], stack, context, line, offset)
  end

  defp xp_ParenthesizedExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_Expr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParenthesizedExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ParenthesizedExpr__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ParenthesizedExpr__10(rest, acc, stack, context, line, offset) do
    xp_ParenthesizedExpr__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParenthesizedExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParenthesizedExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ParenthesizedExpr__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ParenthesizedExpr__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ParenthesizedExpr__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ParenthesizedExpr__13(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ParenthesizedExpr__6(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ParenthesizedExpr__6(
         <<")", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ParenthesizedExpr__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ParenthesizedExpr__6(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_ParenthesizedExpr__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ParenthesizedExpr__15(
      rest,
      [parenthesized_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ParenthesizedExpr__15(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_VarName__0(rest, acc, stack, context, line, offset) do
    xp_VarName__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_VarName__1(rest, acc, stack, context, line, offset) do
    case(xp_EQName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_VarName__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_VarName__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_VarName__3(rest, [var_name: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_VarName__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_VarRef__0(rest, acc, stack, context, line, offset) do
    xp_VarRef__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_VarRef__1(<<"$", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_VarRef__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_VarRef__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"$\"", rest, context, line, offset}
  end

  defp xp_VarRef__2(rest, acc, stack, context, line, offset) do
    case(xp_VarName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_VarRef__3(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_VarRef__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_VarRef__4(rest, [var_ref: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_VarRef__4(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NumericLiteral__0(rest, acc, stack, context, line, offset) do
    xp_NumericLiteral__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NumericLiteral__1(rest, acc, stack, context, line, offset) do
    xp_NumericLiteral__9(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_NumericLiteral__3(rest, acc, stack, context, line, offset) do
    case(xp_DoubleLiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NumericLiteral__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NumericLiteral__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_NumericLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_NumericLiteral__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_NumericLiteral__3(rest, [], stack, context, line, offset)
  end

  defp xp_NumericLiteral__6(rest, acc, stack, context, line, offset) do
    case(xp_DecimalLiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NumericLiteral__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_NumericLiteral__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_NumericLiteral__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_NumericLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_NumericLiteral__8(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_NumericLiteral__6(rest, [], stack, context, line, offset)
  end

  defp xp_NumericLiteral__9(rest, acc, stack, context, line, offset) do
    case(xp_IntegerLiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NumericLiteral__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_NumericLiteral__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_NumericLiteral__10(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_NumericLiteral__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_NumericLiteral__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_NumericLiteral__11(
      rest,
      [numeric_literal: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_NumericLiteral__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Literal__0(rest, acc, stack, context, line, offset) do
    xp_Literal__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Literal__1(rest, acc, stack, context, line, offset) do
    xp_Literal__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_Literal__3(rest, acc, stack, context, line, offset) do
    case(xp_StringLiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Literal__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Literal__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Literal__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Literal__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_Literal__3(rest, [], stack, context, line, offset)
  end

  defp xp_Literal__6(rest, acc, stack, context, line, offset) do
    case(xp_NumericLiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Literal__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_Literal__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Literal__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Literal__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Literal__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Literal__8(rest, [literal: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_Literal__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_PrimaryExpr__0(rest, acc, stack, context, line, offset) do
    xp_PrimaryExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PrimaryExpr__1(rest, acc, stack, context, line, offset) do
    xp_PrimaryExpr__21(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_PrimaryExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_FunctionItemExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrimaryExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PrimaryExpr__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PrimaryExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PrimaryExpr__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PrimaryExpr__3(rest, [], stack, context, line, offset)
  end

  defp xp_PrimaryExpr__6(rest, acc, stack, context, line, offset) do
    case(xp_FunctionCall__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrimaryExpr__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PrimaryExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PrimaryExpr__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PrimaryExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PrimaryExpr__8(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PrimaryExpr__6(rest, [], stack, context, line, offset)
  end

  defp xp_PrimaryExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_FunctionCall__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrimaryExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PrimaryExpr__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PrimaryExpr__10(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PrimaryExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PrimaryExpr__11(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PrimaryExpr__9(rest, [], stack, context, line, offset)
  end

  defp xp_PrimaryExpr__12(rest, acc, stack, context, line, offset) do
    case(xp_ContextItemExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrimaryExpr__13(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PrimaryExpr__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PrimaryExpr__13(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PrimaryExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PrimaryExpr__14(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PrimaryExpr__12(rest, [], stack, context, line, offset)
  end

  defp xp_PrimaryExpr__15(rest, acc, stack, context, line, offset) do
    case(xp_ParenthesizedExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrimaryExpr__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PrimaryExpr__14(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PrimaryExpr__16(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PrimaryExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PrimaryExpr__17(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PrimaryExpr__15(rest, [], stack, context, line, offset)
  end

  defp xp_PrimaryExpr__18(rest, acc, stack, context, line, offset) do
    case(xp_VarRef__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrimaryExpr__19(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PrimaryExpr__17(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PrimaryExpr__19(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PrimaryExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PrimaryExpr__20(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PrimaryExpr__18(rest, [], stack, context, line, offset)
  end

  defp xp_PrimaryExpr__21(rest, acc, stack, context, line, offset) do
    case(xp_Literal__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PrimaryExpr__22(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PrimaryExpr__20(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PrimaryExpr__22(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PrimaryExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PrimaryExpr__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_PrimaryExpr__23(
      rest,
      [primary_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_PrimaryExpr__23(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Predicate__0(rest, acc, stack, context, line, offset) do
    xp_Predicate__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Predicate__1(<<"[", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Predicate__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Predicate__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"[\"", rest, context, line, offset}
  end

  defp xp_Predicate__2(rest, acc, stack, context, line, offset) do
    xp_Predicate__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Predicate__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Predicate__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Predicate__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Predicate__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Predicate__5(rest, acc, stack, context, line, offset) do
    case(xp_Expr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Predicate__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Predicate__6(rest, acc, stack, context, line, offset) do
    xp_Predicate__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Predicate__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Predicate__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Predicate__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Predicate__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Predicate__9(<<"]", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Predicate__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Predicate__9(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"]\"", rest, context, line, offset}
  end

  defp xp_Predicate__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_Predicate__11(
      rest,
      [predicate: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_Predicate__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_PredicateList__0(rest, acc, stack, context, line, offset) do
    xp_PredicateList__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PredicateList__1(rest, acc, stack, context, line, offset) do
    xp_PredicateList__3(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_PredicateList__3(rest, acc, stack, context, line, offset) do
    case(xp_Predicate__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PredicateList__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PredicateList__2(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PredicateList__2(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_PredicateList__5(rest, acc, stack, context, line, offset)
  end

  defp xp_PredicateList__4(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_PredicateList__3(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_PredicateList__5(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_PredicateList__6(
      rest,
      [predicate_list: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_PredicateList__6(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ArgumentList__0(rest, acc, stack, context, line, offset) do
    xp_ArgumentList__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ArgumentList__1(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ArgumentList__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ArgumentList__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_ArgumentList__2(rest, acc, stack, context, line, offset) do
    xp_ArgumentList__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ArgumentList__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ArgumentList__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ArgumentList__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ArgumentList__4(rest, [], stack, context, line, offset)
  end

  defp xp_ArgumentList__6(rest, acc, stack, context, line, offset) do
    xp_ArgumentList__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ArgumentList__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ArgumentList__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ArgumentList__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ArgumentList__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ArgumentList__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ArgumentList__9(rest, acc, stack, context, line, offset) do
    case(xp_Argument__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ArgumentList__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ArgumentList__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ArgumentList__10(rest, acc, stack, context, line, offset) do
    xp_ArgumentList__12(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ArgumentList__12(rest, acc, stack, context, line, offset) do
    xp_ArgumentList__13(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ArgumentList__13(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ArgumentList__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ArgumentList__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ArgumentList__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ArgumentList__15(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ArgumentList__15(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ArgumentList__16(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ArgumentList__15(rest, acc, stack, context, line, offset) do
    xp_ArgumentList__11(rest, acc, stack, context, line, offset)
  end

  defp xp_ArgumentList__16(rest, acc, stack, context, line, offset) do
    xp_ArgumentList__17(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ArgumentList__17(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ArgumentList__18(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ArgumentList__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ArgumentList__18(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ArgumentList__19(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ArgumentList__19(rest, acc, stack, context, line, offset) do
    case(xp_Argument__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ArgumentList__20(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ArgumentList__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ArgumentList__11(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_ArgumentList__21(rest, acc, stack, context, line, offset)
  end

  defp xp_ArgumentList__20(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_ArgumentList__12(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_ArgumentList__21(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ArgumentList__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ArgumentList__3(rest, acc, stack, context, line, offset) do
    xp_ArgumentList__22(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ArgumentList__22(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ArgumentList__23(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ArgumentList__23(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ArgumentList__24(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ArgumentList__24(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ArgumentList__25(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ArgumentList__24(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_ArgumentList__25(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ArgumentList__26(
      rest,
      [argument_list: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ArgumentList__26(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_PostfixExpr__0(rest, acc, stack, context, line, offset) do
    xp_PostfixExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PostfixExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_PrimaryExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PostfixExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PostfixExpr__2(rest, acc, stack, context, line, offset) do
    xp_PostfixExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PostfixExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PostfixExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PostfixExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PostfixExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_PostfixExpr__5(rest, acc, stack, context, line, offset) do
    xp_PostfixExpr__7(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_PostfixExpr__7(rest, acc, stack, context, line, offset) do
    xp_PostfixExpr__12(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_PostfixExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_ArgumentList__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PostfixExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_PostfixExpr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PostfixExpr__10(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PostfixExpr__8(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PostfixExpr__11(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PostfixExpr__9(rest, [], stack, context, line, offset)
  end

  defp xp_PostfixExpr__12(rest, acc, stack, context, line, offset) do
    case(xp_Predicate__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PostfixExpr__13(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PostfixExpr__11(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PostfixExpr__13(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PostfixExpr__8(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PostfixExpr__6(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_PostfixExpr__14(rest, acc, stack, context, line, offset)
  end

  defp xp_PostfixExpr__8(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_PostfixExpr__7(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_PostfixExpr__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_PostfixExpr__15(
      rest,
      [postfix_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_PostfixExpr__15(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Wildcard__0(rest, acc, stack, context, line, offset) do
    xp_Wildcard__37(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_Wildcard__2(rest, acc, stack, context, line, offset) do
    xp_Wildcard__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Wildcard__3(rest, acc, stack, context, line, offset) do
    case(xp_BracedURILiteral__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Wildcard__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Wildcard__4(rest, acc, stack, context, line, offset) do
    xp_Wildcard__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Wildcard__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Wildcard__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Wildcard__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Wildcard__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Wildcard__7(<<"*", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Wildcard__8(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Wildcard__7(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"*\" or xp_NCName, followed by xp_S, followed by string \":\", followed by xp_S, followed by string \"*\" or string \"*\", followed by xp_S, followed by string \":\", followed by xp_S, followed by xp_NCName or xp_BracedURILiteral, followed by xp_S, followed by string \"*\"",
     rest, context, line, offset}
  end

  defp xp_Wildcard__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_Wildcard__9(
      rest,
      [braceduri_wildcard: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_Wildcard__9(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Wildcard__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Wildcard__10(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_Wildcard__2(rest, [], stack, context, line, offset)
  end

  defp xp_Wildcard__11(rest, acc, stack, context, line, offset) do
    xp_Wildcard__12(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Wildcard__12(<<"*", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Wildcard__13(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Wildcard__12(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_Wildcard__10(rest, acc, stack, context, line, offset)
  end

  defp xp_Wildcard__13(rest, acc, stack, context, line, offset) do
    xp_Wildcard__14(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Wildcard__14(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Wildcard__15(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_Wildcard__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Wildcard__15(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Wildcard__16(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Wildcard__16(<<":", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Wildcard__17(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Wildcard__16(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_Wildcard__10(rest, acc, stack, context, line, offset)
  end

  defp xp_Wildcard__17(rest, acc, stack, context, line, offset) do
    xp_Wildcard__18(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Wildcard__18(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Wildcard__19(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_Wildcard__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Wildcard__19(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Wildcard__20(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Wildcard__20(rest, acc, stack, context, line, offset) do
    case(xp_NCName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Wildcard__21(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_Wildcard__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Wildcard__21(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_Wildcard__22(
      rest,
      [prefix_wildcard: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_Wildcard__22(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Wildcard__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Wildcard__23(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_Wildcard__11(rest, [], stack, context, line, offset)
  end

  defp xp_Wildcard__24(rest, acc, stack, context, line, offset) do
    xp_Wildcard__25(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Wildcard__25(rest, acc, stack, context, line, offset) do
    case(xp_NCName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Wildcard__26(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_Wildcard__23(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Wildcard__26(rest, acc, stack, context, line, offset) do
    xp_Wildcard__27(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Wildcard__27(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Wildcard__28(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_Wildcard__23(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Wildcard__28(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Wildcard__29(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Wildcard__29(<<":", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Wildcard__30(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Wildcard__29(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_Wildcard__23(rest, acc, stack, context, line, offset)
  end

  defp xp_Wildcard__30(rest, acc, stack, context, line, offset) do
    xp_Wildcard__31(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Wildcard__31(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Wildcard__32(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_Wildcard__23(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Wildcard__32(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Wildcard__33(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Wildcard__33(<<"*", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Wildcard__34(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Wildcard__33(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_Wildcard__23(rest, acc, stack, context, line, offset)
  end

  defp xp_Wildcard__34(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_Wildcard__35(
      rest,
      [suffix_wildcard: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_Wildcard__35(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Wildcard__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Wildcard__36(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_Wildcard__24(rest, [], stack, context, line, offset)
  end

  defp xp_Wildcard__37(<<"*", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Wildcard__38(rest, [:wildcard] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Wildcard__37(rest, acc, stack, context, line, offset) do
    xp_Wildcard__36(rest, acc, stack, context, line, offset)
  end

  defp xp_Wildcard__38(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Wildcard__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Wildcard__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NameTest__0(rest, acc, stack, context, line, offset) do
    xp_NameTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NameTest__1(rest, acc, stack, context, line, offset) do
    xp_NameTest__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_NameTest__3(rest, acc, stack, context, line, offset) do
    case(xp_Wildcard__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NameTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NameTest__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_NameTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_NameTest__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_NameTest__3(rest, [], stack, context, line, offset)
  end

  defp xp_NameTest__6(rest, acc, stack, context, line, offset) do
    case(xp_EQName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NameTest__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_NameTest__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_NameTest__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_NameTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_NameTest__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_NameTest__8(
      rest,
      [name_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_NameTest__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NodeTest__0(rest, acc, stack, context, line, offset) do
    xp_NodeTest__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NodeTest__1(rest, acc, stack, context, line, offset) do
    xp_NodeTest__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_NodeTest__3(rest, acc, stack, context, line, offset) do
    case(xp_NameTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NodeTest__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_NodeTest__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_NodeTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_NodeTest__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_NodeTest__3(rest, [], stack, context, line, offset)
  end

  defp xp_NodeTest__6(rest, acc, stack, context, line, offset) do
    case(xp_KindTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_NodeTest__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_NodeTest__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_NodeTest__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_NodeTest__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_NodeTest__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_NodeTest__8(
      rest,
      [node_test: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_NodeTest__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AbbrevReverseStep__0(
         <<"..", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_AbbrevReverseStep__1(
      rest,
      [:abbrev_reverse_step] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp xp_AbbrevReverseStep__0(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"..\"", rest, context, line, offset}
  end

  defp xp_AbbrevReverseStep__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ReverseAxis__0(rest, acc, stack, context, line, offset) do
    xp_ReverseAxis__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ReverseAxis__1(
         <<"parent", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ReverseAxis__2(rest, [:parent] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp xp_ReverseAxis__1(
         <<"ancestor", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ReverseAxis__2(rest, [:ancestor] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp xp_ReverseAxis__1(
         <<"preceding-sibling", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ReverseAxis__2(
      rest,
      [:preceding_sibling] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 17
    )
  end

  defp xp_ReverseAxis__1(
         <<"preceding", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ReverseAxis__2(rest, [:preceding] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp xp_ReverseAxis__1(
         <<"ancestor-or-self", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ReverseAxis__2(
      rest,
      [:ancestor_or_self] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 16
    )
  end

  defp xp_ReverseAxis__1(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"parent\" or string \"ancestor\" or string \"preceding-sibling\" or string \"preceding\" or string \"ancestor-or-self\"",
     rest, context, line, offset}
  end

  defp xp_ReverseAxis__2(rest, acc, stack, context, line, offset) do
    xp_ReverseAxis__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ReverseAxis__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ReverseAxis__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ReverseAxis__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ReverseAxis__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ReverseAxis__5(<<"::", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ReverseAxis__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_ReverseAxis__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"::\"", rest, context, line, offset}
  end

  defp xp_ReverseAxis__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ReverseAxis__7(
      rest,
      [reverse_axis: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ReverseAxis__7(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ReverseStep__0(rest, acc, stack, context, line, offset) do
    xp_ReverseStep__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ReverseStep__1(rest, acc, stack, context, line, offset) do
    xp_ReverseStep__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ReverseStep__3(rest, acc, stack, context, line, offset) do
    case(xp_AbbrevReverseStep__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ReverseStep__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ReverseStep__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ReverseStep__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ReverseStep__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ReverseStep__3(rest, [], stack, context, line, offset)
  end

  defp xp_ReverseStep__6(rest, acc, stack, context, line, offset) do
    case(xp_ReverseAxis__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ReverseStep__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ReverseStep__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ReverseStep__7(rest, acc, stack, context, line, offset) do
    case(xp_NodeTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ReverseStep__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ReverseStep__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ReverseStep__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ReverseStep__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ReverseStep__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ReverseStep__9(
      rest,
      [reverse_step: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ReverseStep__9(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AbbrevForwardStep__0(rest, acc, stack, context, line, offset) do
    xp_AbbrevForwardStep__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AbbrevForwardStep__1(rest, acc, stack, context, line, offset) do
    xp_AbbrevForwardStep__5(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_AbbrevForwardStep__3(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AbbrevForwardStep__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AbbrevForwardStep__4(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_AbbrevForwardStep__3(rest, [], stack, context, line, offset)
  end

  defp xp_AbbrevForwardStep__5(
         <<"@", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_AbbrevForwardStep__6(
      rest,
      [:attribute] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 1
    )
  end

  defp xp_AbbrevForwardStep__5(rest, acc, stack, context, line, offset) do
    xp_AbbrevForwardStep__4(rest, acc, stack, context, line, offset)
  end

  defp xp_AbbrevForwardStep__6(rest, acc, stack, context, line, offset) do
    xp_AbbrevForwardStep__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AbbrevForwardStep__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AbbrevForwardStep__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_AbbrevForwardStep__4(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AbbrevForwardStep__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AbbrevForwardStep__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AbbrevForwardStep__9(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AbbrevForwardStep__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AbbrevForwardStep__2(rest, acc, stack, context, line, offset) do
    case(xp_NodeTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AbbrevForwardStep__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AbbrevForwardStep__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AbbrevForwardStep__11(
      rest,
      [abbrev_forward_step: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AbbrevForwardStep__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ForwardAxis__0(rest, acc, stack, context, line, offset) do
    xp_ForwardAxis__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ForwardAxis__1(<<"child", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ForwardAxis__2(rest, [:child] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp xp_ForwardAxis__1(
         <<"descendant", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ForwardAxis__2(rest, [:descendant] ++ acc, stack, context, comb__line, comb__offset + 10)
  end

  defp xp_ForwardAxis__1(
         <<"attribute", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ForwardAxis__2(rest, [:attribute] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp xp_ForwardAxis__1(<<"self", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ForwardAxis__2(rest, [:self] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_ForwardAxis__1(
         <<"descendant-or-self", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ForwardAxis__2(
      rest,
      [:descendant_or_self] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 18
    )
  end

  defp xp_ForwardAxis__1(
         <<"following-sibling", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ForwardAxis__2(
      rest,
      [:following_sibling] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 17
    )
  end

  defp xp_ForwardAxis__1(
         <<"following", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ForwardAxis__2(rest, [:following] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp xp_ForwardAxis__1(
         <<"namespace", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_ForwardAxis__2(rest, [:namespace] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp xp_ForwardAxis__1(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"child\" or string \"descendant\" or string \"attribute\" or string \"self\" or string \"descendant-or-self\" or string \"following-sibling\" or string \"following\" or string \"namespace\"",
     rest, context, line, offset}
  end

  defp xp_ForwardAxis__2(rest, acc, stack, context, line, offset) do
    xp_ForwardAxis__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ForwardAxis__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForwardAxis__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ForwardAxis__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ForwardAxis__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ForwardAxis__5(<<"::", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ForwardAxis__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_ForwardAxis__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"::\"", rest, context, line, offset}
  end

  defp xp_ForwardAxis__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ForwardAxis__7(
      rest,
      [forward_axis: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ForwardAxis__7(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ForwardStep__0(rest, acc, stack, context, line, offset) do
    xp_ForwardStep__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ForwardStep__1(rest, acc, stack, context, line, offset) do
    xp_ForwardStep__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ForwardStep__3(rest, acc, stack, context, line, offset) do
    case(xp_AbbrevForwardStep__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForwardStep__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ForwardStep__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ForwardStep__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ForwardStep__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ForwardStep__3(rest, [], stack, context, line, offset)
  end

  defp xp_ForwardStep__6(rest, acc, stack, context, line, offset) do
    case(xp_ForwardAxis__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForwardStep__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ForwardStep__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ForwardStep__7(rest, acc, stack, context, line, offset) do
    xp_ForwardStep__8(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ForwardStep__8(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForwardStep__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ForwardStep__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ForwardStep__9(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ForwardStep__10(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ForwardStep__10(rest, acc, stack, context, line, offset) do
    case(xp_NodeTest__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForwardStep__11(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ForwardStep__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ForwardStep__11(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ForwardStep__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ForwardStep__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ForwardStep__12(
      rest,
      [forward_step: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ForwardStep__12(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AxisStep__0(rest, acc, stack, context, line, offset) do
    xp_AxisStep__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AxisStep__1(rest, acc, stack, context, line, offset) do
    xp_AxisStep__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_AxisStep__3(rest, acc, stack, context, line, offset) do
    case(xp_ForwardStep__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AxisStep__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AxisStep__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AxisStep__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AxisStep__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_AxisStep__3(rest, [], stack, context, line, offset)
  end

  defp xp_AxisStep__6(rest, acc, stack, context, line, offset) do
    case(xp_ReverseStep__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AxisStep__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_AxisStep__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AxisStep__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_AxisStep__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_AxisStep__2(rest, acc, stack, context, line, offset) do
    xp_AxisStep__8(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AxisStep__8(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AxisStep__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AxisStep__9(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AxisStep__10(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AxisStep__10(rest, acc, stack, context, line, offset) do
    case(xp_PredicateList__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AxisStep__11(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AxisStep__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AxisStep__12(
      rest,
      [axis_step: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AxisStep__12(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_StepExpr__0(rest, acc, stack, context, line, offset) do
    xp_StepExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_StepExpr__1(rest, acc, stack, context, line, offset) do
    xp_StepExpr__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_StepExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_AxisStep__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_StepExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_StepExpr__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_StepExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_StepExpr__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_StepExpr__3(rest, [], stack, context, line, offset)
  end

  defp xp_StepExpr__6(rest, acc, stack, context, line, offset) do
    case(xp_PostfixExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_StepExpr__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_StepExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_StepExpr__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_StepExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_StepExpr__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_StepExpr__8(
      rest,
      [step_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_StepExpr__8(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_RelativePathExpr__0(rest, acc, stack, context, line, offset) do
    xp_RelativePathExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_RelativePathExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_StepExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_RelativePathExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_RelativePathExpr__2(rest, acc, stack, context, line, offset) do
    xp_RelativePathExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_RelativePathExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_RelativePathExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_RelativePathExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_RelativePathExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_RelativePathExpr__5(rest, acc, stack, context, line, offset) do
    xp_RelativePathExpr__7(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_RelativePathExpr__7(
         <<"//", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_RelativePathExpr__8(
      rest,
      [:descendant] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp xp_RelativePathExpr__7(
         <<"/", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_RelativePathExpr__8(rest, [:child] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_RelativePathExpr__7(rest, acc, stack, context, line, offset) do
    xp_RelativePathExpr__6(rest, acc, stack, context, line, offset)
  end

  defp xp_RelativePathExpr__8(rest, acc, stack, context, line, offset) do
    xp_RelativePathExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_RelativePathExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_RelativePathExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_RelativePathExpr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_RelativePathExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_RelativePathExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_RelativePathExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_StepExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_RelativePathExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_RelativePathExpr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_RelativePathExpr__6(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_RelativePathExpr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_RelativePathExpr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_RelativePathExpr__7(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_RelativePathExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_RelativePathExpr__14(
      rest,
      [relative_path_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_RelativePathExpr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_PathExpr__0(rest, acc, stack, context, line, offset) do
    xp_PathExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PathExpr__1(rest, acc, stack, context, line, offset) do
    xp_PathExpr__15(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_PathExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_RelativePathExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PathExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_PathExpr__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PathExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PathExpr__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PathExpr__3(rest, [], stack, context, line, offset)
  end

  defp xp_PathExpr__6(rest, acc, stack, context, line, offset) do
    xp_PathExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PathExpr__7(<<"/", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_PathExpr__8(rest, acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_PathExpr__7(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_PathExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_PathExpr__8(rest, acc, stack, context, line, offset) do
    xp_PathExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PathExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PathExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_PathExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PathExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PathExpr__11(rest, acc, stack, context, line, offset)
  end

  defp xp_PathExpr__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PathExpr__12(rest, [:root] ++ acc, stack, context, line, offset)
  end

  defp xp_PathExpr__12(rest, acc, stack, context, line, offset) do
    case(xp_RelativePathExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PathExpr__13(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PathExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PathExpr__13(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PathExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PathExpr__14(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_PathExpr__6(rest, [], stack, context, line, offset)
  end

  defp xp_PathExpr__15(rest, acc, stack, context, line, offset) do
    xp_PathExpr__16(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PathExpr__16(<<"//", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_PathExpr__17(rest, acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_PathExpr__16(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_PathExpr__14(rest, acc, stack, context, line, offset)
  end

  defp xp_PathExpr__17(rest, acc, stack, context, line, offset) do
    xp_PathExpr__18(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_PathExpr__18(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PathExpr__19(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_PathExpr__14(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PathExpr__19(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PathExpr__20(rest, acc, stack, context, line, offset)
  end

  defp xp_PathExpr__20(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_PathExpr__21(rest, [:root_descendant] ++ acc, stack, context, line, offset)
  end

  defp xp_PathExpr__21(rest, acc, stack, context, line, offset) do
    case(xp_RelativePathExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_PathExpr__22(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_PathExpr__14(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_PathExpr__22(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_PathExpr__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_PathExpr__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_PathExpr__23(
      rest,
      [path_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_PathExpr__23(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SimpleMapExpr__0(rest, acc, stack, context, line, offset) do
    xp_SimpleMapExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleMapExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_PathExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleMapExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleMapExpr__2(rest, acc, stack, context, line, offset) do
    xp_SimpleMapExpr__4(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_SimpleMapExpr__4(rest, acc, stack, context, line, offset) do
    xp_SimpleMapExpr__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleMapExpr__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleMapExpr__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_SimpleMapExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SimpleMapExpr__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleMapExpr__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleMapExpr__7(<<"!", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_SimpleMapExpr__8(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SimpleMapExpr__7(rest, acc, stack, context, line, offset) do
    xp_SimpleMapExpr__3(rest, acc, stack, context, line, offset)
  end

  defp xp_SimpleMapExpr__8(rest, acc, stack, context, line, offset) do
    xp_SimpleMapExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleMapExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleMapExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_SimpleMapExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SimpleMapExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleMapExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleMapExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_PathExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleMapExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_SimpleMapExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SimpleMapExpr__3(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_SimpleMapExpr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_SimpleMapExpr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_SimpleMapExpr__4(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_SimpleMapExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SimpleMapExpr__14(
      rest,
      [simple_map_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SimpleMapExpr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_NodeComp__0(rest, acc, stack, context, line, offset) do
    xp_NodeComp__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_NodeComp__1(<<"is", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_NodeComp__2(rest, [:is] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_NodeComp__1(<<"<<", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_NodeComp__2(rest, [:precedes] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_NodeComp__1(<<">>", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_NodeComp__2(rest, [:follows] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_NodeComp__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"is\" or string \"<<\" or string \">>\"", rest, context, line,
     offset}
  end

  defp xp_NodeComp__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_NodeComp__3(
      rest,
      [node_comp: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_NodeComp__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ValueComp__0(rest, acc, stack, context, line, offset) do
    xp_ValueComp__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ValueComp__1(<<"eq", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ValueComp__2(rest, [:eq] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_ValueComp__1(<<"ne", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ValueComp__2(rest, [:ne] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_ValueComp__1(<<"lt", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ValueComp__2(rest, [:lt] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_ValueComp__1(<<"le", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ValueComp__2(rest, [:le] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_ValueComp__1(<<"gt", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ValueComp__2(rest, [:gt] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_ValueComp__1(<<"ge", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ValueComp__2(rest, [:ge] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_ValueComp__1(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"eq\" or string \"ne\" or string \"lt\" or string \"le\" or string \"gt\" or string \"ge\"",
     rest, context, line, offset}
  end

  defp xp_ValueComp__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ValueComp__3(
      rest,
      [value_comp: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ValueComp__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_GeneralComp__0(rest, acc, stack, context, line, offset) do
    xp_GeneralComp__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_GeneralComp__1(<<"=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_GeneralComp__2(rest, [:=] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_GeneralComp__1(<<"!=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_GeneralComp__2(rest, [:!=] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_GeneralComp__1(<<"<", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_GeneralComp__2(rest, [:<] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_GeneralComp__1(<<"<=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_GeneralComp__2(rest, [:<=] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_GeneralComp__1(<<">", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_GeneralComp__2(rest, [:>] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_GeneralComp__1(<<">=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_GeneralComp__2(rest, [:>=] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_GeneralComp__1(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"=\" or string \"!=\" or string \"<\" or string \"<=\" or string \">\" or string \">=\"",
     rest, context, line, offset}
  end

  defp xp_GeneralComp__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_GeneralComp__3(
      rest,
      [general_comp: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_GeneralComp__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ValueExpr__0(rest, acc, stack, context, line, offset) do
    xp_ValueExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ValueExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_SimpleMapExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ValueExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ValueExpr__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ValueExpr__3(
      rest,
      [value_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ValueExpr__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_UnaryExpr__0(rest, acc, stack, context, line, offset) do
    xp_UnaryExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_UnaryExpr__1(rest, acc, stack, context, line, offset) do
    xp_UnaryExpr__3(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp xp_UnaryExpr__3(<<"-", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_UnaryExpr__4(rest, [:minus] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_UnaryExpr__3(<<"+", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_UnaryExpr__4(rest, [:plus] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_UnaryExpr__3(rest, acc, stack, context, line, offset) do
    xp_UnaryExpr__2(rest, acc, stack, context, line, offset)
  end

  defp xp_UnaryExpr__2(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_UnaryExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_UnaryExpr__4(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_UnaryExpr__3(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_UnaryExpr__5(rest, acc, stack, context, line, offset) do
    xp_UnaryExpr__6(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_UnaryExpr__6(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_UnaryExpr__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_UnaryExpr__7(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_UnaryExpr__8(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_UnaryExpr__8(rest, acc, stack, context, line, offset) do
    case(xp_ValueExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_UnaryExpr__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_UnaryExpr__9(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_UnaryExpr__10(
      rest,
      [unary_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_UnaryExpr__10(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_CastExpr__0(rest, acc, stack, context, line, offset) do
    xp_CastExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CastExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_UnaryExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_CastExpr__2(rest, acc, stack, context, line, offset) do
    xp_CastExpr__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_CastExpr__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_CastExpr__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_CastExpr__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_CastExpr__4(rest, [], stack, context, line, offset)
  end

  defp xp_CastExpr__6(rest, acc, stack, context, line, offset) do
    xp_CastExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CastExpr__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastExpr__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_CastExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CastExpr__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_CastExpr__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_CastExpr__9(<<"cast", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_CastExpr__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_CastExpr__9(rest, acc, stack, context, line, offset) do
    xp_CastExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_CastExpr__10(rest, acc, stack, context, line, offset) do
    xp_CastExpr__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CastExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_CastExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CastExpr__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_CastExpr__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_CastExpr__13(<<"as", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_CastExpr__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_CastExpr__13(rest, acc, stack, context, line, offset) do
    xp_CastExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_CastExpr__14(rest, acc, stack, context, line, offset) do
    xp_CastExpr__15(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CastExpr__15(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastExpr__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_CastExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CastExpr__16(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_CastExpr__17(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_CastExpr__17(rest, acc, stack, context, line, offset) do
    case(xp_SingleType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastExpr__18(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_CastExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CastExpr__18(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_CastExpr__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_CastExpr__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_CastExpr__19(
      rest,
      [cast_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_CastExpr__19(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_CastableExpr__0(rest, acc, stack, context, line, offset) do
    xp_CastableExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CastableExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_CastExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastableExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_CastableExpr__2(rest, acc, stack, context, line, offset) do
    xp_CastableExpr__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_CastableExpr__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_CastableExpr__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_CastableExpr__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_CastableExpr__4(rest, [], stack, context, line, offset)
  end

  defp xp_CastableExpr__6(rest, acc, stack, context, line, offset) do
    xp_CastableExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CastableExpr__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastableExpr__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_CastableExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CastableExpr__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_CastableExpr__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_CastableExpr__9(
         <<"castable", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_CastableExpr__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp xp_CastableExpr__9(rest, acc, stack, context, line, offset) do
    xp_CastableExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_CastableExpr__10(rest, acc, stack, context, line, offset) do
    xp_CastableExpr__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CastableExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastableExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_CastableExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CastableExpr__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_CastableExpr__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_CastableExpr__13(<<"as", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_CastableExpr__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_CastableExpr__13(rest, acc, stack, context, line, offset) do
    xp_CastableExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_CastableExpr__14(rest, acc, stack, context, line, offset) do
    xp_CastableExpr__15(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_CastableExpr__15(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastableExpr__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_CastableExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CastableExpr__16(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_CastableExpr__17(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_CastableExpr__17(rest, acc, stack, context, line, offset) do
    case(xp_SingleType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_CastableExpr__18(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_CastableExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_CastableExpr__18(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_CastableExpr__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_CastableExpr__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_CastableExpr__19(
      rest,
      [castable_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_CastableExpr__19(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_TreatExpr__0(rest, acc, stack, context, line, offset) do
    xp_TreatExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TreatExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_CastableExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TreatExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_TreatExpr__2(rest, acc, stack, context, line, offset) do
    xp_TreatExpr__6(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_TreatExpr__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_TreatExpr__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_TreatExpr__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_TreatExpr__4(rest, [], stack, context, line, offset)
  end

  defp xp_TreatExpr__6(rest, acc, stack, context, line, offset) do
    xp_TreatExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TreatExpr__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TreatExpr__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_TreatExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TreatExpr__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TreatExpr__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TreatExpr__9(<<"treat", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_TreatExpr__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp xp_TreatExpr__9(rest, acc, stack, context, line, offset) do
    xp_TreatExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_TreatExpr__10(rest, acc, stack, context, line, offset) do
    xp_TreatExpr__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TreatExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TreatExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_TreatExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TreatExpr__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TreatExpr__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TreatExpr__13(<<"as", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_TreatExpr__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_TreatExpr__13(rest, acc, stack, context, line, offset) do
    xp_TreatExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_TreatExpr__14(rest, acc, stack, context, line, offset) do
    xp_TreatExpr__15(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_TreatExpr__15(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TreatExpr__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_TreatExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TreatExpr__16(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_TreatExpr__17(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_TreatExpr__17(rest, acc, stack, context, line, offset) do
    case(xp_SequenceType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_TreatExpr__18(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_TreatExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_TreatExpr__18(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_TreatExpr__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_TreatExpr__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_TreatExpr__19(
      rest,
      [treat_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_TreatExpr__19(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_InstanceofExpr__0(rest, acc, stack, context, line, offset) do
    xp_InstanceofExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InstanceofExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_TreatExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InstanceofExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_InstanceofExpr__2(rest, acc, stack, context, line, offset) do
    xp_InstanceofExpr__6(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_InstanceofExpr__4(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_InstanceofExpr__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_InstanceofExpr__5(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_InstanceofExpr__4(rest, [], stack, context, line, offset)
  end

  defp xp_InstanceofExpr__6(rest, acc, stack, context, line, offset) do
    xp_InstanceofExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InstanceofExpr__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InstanceofExpr__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_InstanceofExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_InstanceofExpr__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_InstanceofExpr__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_InstanceofExpr__9(
         <<"instance", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_InstanceofExpr__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp xp_InstanceofExpr__9(rest, acc, stack, context, line, offset) do
    xp_InstanceofExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_InstanceofExpr__10(rest, acc, stack, context, line, offset) do
    xp_InstanceofExpr__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_InstanceofExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InstanceofExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_InstanceofExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_InstanceofExpr__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_InstanceofExpr__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_InstanceofExpr__13(
         <<"of", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_InstanceofExpr__14(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_InstanceofExpr__13(rest, acc, stack, context, line, offset) do
    xp_InstanceofExpr__5(rest, acc, stack, context, line, offset)
  end

  defp xp_InstanceofExpr__14(rest, acc, stack, context, line, offset) do
    case(xp_SequenceType__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_InstanceofExpr__15(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_InstanceofExpr__5(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_InstanceofExpr__15(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_InstanceofExpr__3(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_InstanceofExpr__3(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_InstanceofExpr__16(
      rest,
      [instanceof_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_InstanceofExpr__16(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_IntersectExceptExpr__0(rest, acc, stack, context, line, offset) do
    xp_IntersectExceptExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IntersectExceptExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_InstanceofExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IntersectExceptExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IntersectExceptExpr__2(rest, acc, stack, context, line, offset) do
    xp_IntersectExceptExpr__4(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_IntersectExceptExpr__4(rest, acc, stack, context, line, offset) do
    xp_IntersectExceptExpr__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IntersectExceptExpr__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IntersectExceptExpr__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_IntersectExceptExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_IntersectExceptExpr__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IntersectExceptExpr__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IntersectExceptExpr__7(
         <<"intersect", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_IntersectExceptExpr__8(
      rest,
      [:intersect] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 9
    )
  end

  defp xp_IntersectExceptExpr__7(
         <<"except", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_IntersectExceptExpr__8(
      rest,
      [:except] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 6
    )
  end

  defp xp_IntersectExceptExpr__7(rest, acc, stack, context, line, offset) do
    xp_IntersectExceptExpr__3(rest, acc, stack, context, line, offset)
  end

  defp xp_IntersectExceptExpr__8(rest, acc, stack, context, line, offset) do
    xp_IntersectExceptExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IntersectExceptExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IntersectExceptExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_IntersectExceptExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_IntersectExceptExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IntersectExceptExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IntersectExceptExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_InstanceofExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IntersectExceptExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_IntersectExceptExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_IntersectExceptExpr__3(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_IntersectExceptExpr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_IntersectExceptExpr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_IntersectExceptExpr__4(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_IntersectExceptExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_IntersectExceptExpr__14(
      rest,
      [intersect_except_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_IntersectExceptExpr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_UnionExpr__0(rest, acc, stack, context, line, offset) do
    xp_UnionExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_UnionExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_IntersectExceptExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_UnionExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_UnionExpr__2(rest, acc, stack, context, line, offset) do
    xp_UnionExpr__4(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp xp_UnionExpr__4(rest, acc, stack, context, line, offset) do
    xp_UnionExpr__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_UnionExpr__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_UnionExpr__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_UnionExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_UnionExpr__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_UnionExpr__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_UnionExpr__7(<<"union", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_UnionExpr__8(rest, [:union] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp xp_UnionExpr__7(<<"|", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_UnionExpr__8(rest, [:union] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_UnionExpr__7(rest, acc, stack, context, line, offset) do
    xp_UnionExpr__3(rest, acc, stack, context, line, offset)
  end

  defp xp_UnionExpr__8(rest, acc, stack, context, line, offset) do
    xp_UnionExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_UnionExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_UnionExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_UnionExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_UnionExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_UnionExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_UnionExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_IntersectExceptExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_UnionExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_UnionExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_UnionExpr__3(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_UnionExpr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_UnionExpr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_UnionExpr__4(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_UnionExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_UnionExpr__14(
      rest,
      [union_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_UnionExpr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_MultiplicativeExpr__0(rest, acc, stack, context, line, offset) do
    xp_MultiplicativeExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_MultiplicativeExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_UnionExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_MultiplicativeExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_MultiplicativeExpr__2(rest, acc, stack, context, line, offset) do
    xp_MultiplicativeExpr__4(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_MultiplicativeExpr__4(rest, acc, stack, context, line, offset) do
    xp_MultiplicativeExpr__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_MultiplicativeExpr__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_MultiplicativeExpr__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_MultiplicativeExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_MultiplicativeExpr__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_MultiplicativeExpr__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_MultiplicativeExpr__7(
         <<"*", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_MultiplicativeExpr__8(rest, [:times] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_MultiplicativeExpr__7(
         <<"div", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_MultiplicativeExpr__8(rest, [:div] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp xp_MultiplicativeExpr__7(
         <<"idiv", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_MultiplicativeExpr__8(rest, [:idiv] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_MultiplicativeExpr__7(
         <<"mod", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_MultiplicativeExpr__8(rest, [:mod] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp xp_MultiplicativeExpr__7(rest, acc, stack, context, line, offset) do
    xp_MultiplicativeExpr__3(rest, acc, stack, context, line, offset)
  end

  defp xp_MultiplicativeExpr__8(rest, acc, stack, context, line, offset) do
    xp_MultiplicativeExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_MultiplicativeExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_MultiplicativeExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_MultiplicativeExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_MultiplicativeExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_MultiplicativeExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_MultiplicativeExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_UnionExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_MultiplicativeExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_MultiplicativeExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_MultiplicativeExpr__3(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_MultiplicativeExpr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_MultiplicativeExpr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_MultiplicativeExpr__4(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_MultiplicativeExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_MultiplicativeExpr__14(
      rest,
      [multiplicative_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_MultiplicativeExpr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AdditiveExpr__0(rest, acc, stack, context, line, offset) do
    xp_AdditiveExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AdditiveExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_MultiplicativeExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AdditiveExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AdditiveExpr__2(rest, acc, stack, context, line, offset) do
    xp_AdditiveExpr__4(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_AdditiveExpr__4(rest, acc, stack, context, line, offset) do
    xp_AdditiveExpr__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AdditiveExpr__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AdditiveExpr__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_AdditiveExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AdditiveExpr__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AdditiveExpr__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AdditiveExpr__7(<<"+", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AdditiveExpr__8(rest, [:add] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AdditiveExpr__7(<<"-", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AdditiveExpr__8(rest, [:sub] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_AdditiveExpr__7(rest, acc, stack, context, line, offset) do
    xp_AdditiveExpr__3(rest, acc, stack, context, line, offset)
  end

  defp xp_AdditiveExpr__8(rest, acc, stack, context, line, offset) do
    xp_AdditiveExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AdditiveExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AdditiveExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_AdditiveExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AdditiveExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AdditiveExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AdditiveExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_MultiplicativeExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AdditiveExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_AdditiveExpr__3(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AdditiveExpr__3(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_AdditiveExpr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_AdditiveExpr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_AdditiveExpr__4(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_AdditiveExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_AdditiveExpr__14(
      rest,
      [additive_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_AdditiveExpr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_RangeExpr__0(rest, acc, stack, context, line, offset) do
    xp_RangeExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_RangeExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_AdditiveExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_RangeExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_RangeExpr__2(rest, acc, stack, context, line, offset) do
    xp_RangeExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_RangeExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_RangeExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_RangeExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_RangeExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_RangeExpr__5(rest, acc, stack, context, line, offset) do
    xp_RangeExpr__9(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_RangeExpr__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_RangeExpr__6(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_RangeExpr__8(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_RangeExpr__7(rest, [], stack, context, line, offset)
  end

  defp xp_RangeExpr__9(<<"to", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_RangeExpr__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_RangeExpr__9(rest, acc, stack, context, line, offset) do
    xp_RangeExpr__8(rest, acc, stack, context, line, offset)
  end

  defp xp_RangeExpr__10(rest, acc, stack, context, line, offset) do
    xp_RangeExpr__11(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_RangeExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_RangeExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_RangeExpr__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_RangeExpr__12(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_RangeExpr__13(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_RangeExpr__13(rest, acc, stack, context, line, offset) do
    case(xp_AdditiveExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_RangeExpr__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_RangeExpr__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_RangeExpr__14(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_RangeExpr__6(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_RangeExpr__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_RangeExpr__15(
      rest,
      [range_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_RangeExpr__15(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_StringConcatExpr__0(rest, acc, stack, context, line, offset) do
    xp_StringConcatExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_StringConcatExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_RangeExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_StringConcatExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_StringConcatExpr__2(rest, acc, stack, context, line, offset) do
    xp_StringConcatExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_StringConcatExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_StringConcatExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_StringConcatExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_StringConcatExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_StringConcatExpr__5(rest, acc, stack, context, line, offset) do
    xp_StringConcatExpr__7(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_StringConcatExpr__7(rest, acc, stack, context, line, offset) do
    xp_StringConcatExpr__8(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_StringConcatExpr__8(
         <<"||", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_StringConcatExpr__9(rest, acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_StringConcatExpr__8(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_StringConcatExpr__6(rest, acc, stack, context, line, offset)
  end

  defp xp_StringConcatExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_RangeExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_StringConcatExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_StringConcatExpr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_StringConcatExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_StringConcatExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_StringConcatExpr__6(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_StringConcatExpr__12(rest, acc, stack, context, line, offset)
  end

  defp xp_StringConcatExpr__11(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_StringConcatExpr__7(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_StringConcatExpr__12(rest, acc, stack, context, line, offset) do
    xp_StringConcatExpr__13(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_StringConcatExpr__13(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_StringConcatExpr__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_StringConcatExpr__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_StringConcatExpr__15(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_StringConcatExpr__15(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_StringConcatExpr__16(
      rest,
      [string_concat_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_StringConcatExpr__16(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ComparisonExpr__0(rest, acc, stack, context, line, offset) do
    xp_ComparisonExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ComparisonExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_StringConcatExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ComparisonExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ComparisonExpr__2(rest, acc, stack, context, line, offset) do
    xp_ComparisonExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ComparisonExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ComparisonExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ComparisonExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ComparisonExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ComparisonExpr__5(rest, acc, stack, context, line, offset) do
    xp_ComparisonExpr__9(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ComparisonExpr__7(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ComparisonExpr__6(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ComparisonExpr__8(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ComparisonExpr__7(rest, [], stack, context, line, offset)
  end

  defp xp_ComparisonExpr__9(rest, acc, stack, context, line, offset) do
    xp_ComparisonExpr__17(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ComparisonExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_NodeComp__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ComparisonExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_ComparisonExpr__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ComparisonExpr__12(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ComparisonExpr__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ComparisonExpr__13(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ComparisonExpr__11(rest, [], stack, context, line, offset)
  end

  defp xp_ComparisonExpr__14(rest, acc, stack, context, line, offset) do
    case(xp_GeneralComp__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ComparisonExpr__15(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ComparisonExpr__13(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ComparisonExpr__15(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ComparisonExpr__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ComparisonExpr__16(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ComparisonExpr__14(rest, [], stack, context, line, offset)
  end

  defp xp_ComparisonExpr__17(rest, acc, stack, context, line, offset) do
    case(xp_ValueComp__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ComparisonExpr__18(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ComparisonExpr__16(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ComparisonExpr__18(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ComparisonExpr__10(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ComparisonExpr__10(rest, acc, stack, context, line, offset) do
    xp_ComparisonExpr__19(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ComparisonExpr__19(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ComparisonExpr__20(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ComparisonExpr__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ComparisonExpr__20(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ComparisonExpr__21(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ComparisonExpr__21(rest, acc, stack, context, line, offset) do
    case(xp_StringConcatExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ComparisonExpr__22(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ComparisonExpr__8(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ComparisonExpr__22(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ComparisonExpr__6(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ComparisonExpr__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ComparisonExpr__23(
      rest,
      [comparison_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ComparisonExpr__23(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_AndExpr__0(rest, acc, stack, context, line, offset) do
    xp_AndExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AndExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_ComparisonExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AndExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AndExpr__2(rest, acc, stack, context, line, offset) do
    xp_AndExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AndExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AndExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_AndExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AndExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AndExpr__5(rest, acc, stack, context, line, offset) do
    xp_AndExpr__7(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp xp_AndExpr__7(<<"and", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_AndExpr__8(rest, [] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp xp_AndExpr__7(rest, acc, stack, context, line, offset) do
    xp_AndExpr__6(rest, acc, stack, context, line, offset)
  end

  defp xp_AndExpr__8(rest, acc, stack, context, line, offset) do
    xp_AndExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_AndExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AndExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_AndExpr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AndExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AndExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_AndExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_ComparisonExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_AndExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_AndExpr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_AndExpr__6(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_AndExpr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_AndExpr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_AndExpr__7(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_AndExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_AndExpr__14(rest, [and: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_AndExpr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_OrExpr__0(rest, acc, stack, context, line, offset) do
    xp_OrExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_OrExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_AndExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_OrExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_OrExpr__2(rest, acc, stack, context, line, offset) do
    xp_OrExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_OrExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_OrExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_OrExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_OrExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_OrExpr__5(rest, acc, stack, context, line, offset) do
    xp_OrExpr__7(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp xp_OrExpr__7(<<"or", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_OrExpr__8(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_OrExpr__7(rest, acc, stack, context, line, offset) do
    xp_OrExpr__6(rest, acc, stack, context, line, offset)
  end

  defp xp_OrExpr__8(rest, acc, stack, context, line, offset) do
    xp_OrExpr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_OrExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_OrExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_OrExpr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_OrExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_OrExpr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_OrExpr__11(rest, acc, stack, context, line, offset) do
    case(xp_AndExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_OrExpr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_OrExpr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_OrExpr__6(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_OrExpr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_OrExpr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_OrExpr__7(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_OrExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_OrExpr__14(rest, [or: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_OrExpr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_IfExpr__0(rest, acc, stack, context, line, offset) do
    xp_IfExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__1(rest, acc, stack, context, line, offset) do
    xp_IfExpr__2(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__2(rest, acc, stack, context, line, offset) do
    xp_IfExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__3(rest, acc, stack, context, line, offset) do
    xp_IfExpr__4(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__4(<<"if", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_IfExpr__5(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_IfExpr__4(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"if\"", rest, context, line, offset}
  end

  defp xp_IfExpr__5(rest, acc, stack, context, line, offset) do
    xp_IfExpr__6(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__6(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__7(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__7(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__8(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__8(<<"(", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_IfExpr__9(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_IfExpr__8(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"(\"", rest, context, line, offset}
  end

  defp xp_IfExpr__9(rest, acc, stack, context, line, offset) do
    xp_IfExpr__10(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__10(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__11(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__12(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__12(rest, acc, stack, context, line, offset) do
    case(xp_Expr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__13(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__14(rest, [cond: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__14(rest, acc, stack, context, line, offset) do
    xp_IfExpr__15(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__15(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__16(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__17(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__17(<<")", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_IfExpr__18(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_IfExpr__17(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \")\"", rest, context, line, offset}
  end

  defp xp_IfExpr__18(rest, acc, stack, context, line, offset) do
    xp_IfExpr__19(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__19(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__20(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__20(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__21(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__21(<<"then", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_IfExpr__22(rest, [] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_IfExpr__21(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"then\"", rest, context, line, offset}
  end

  defp xp_IfExpr__22(rest, acc, stack, context, line, offset) do
    xp_IfExpr__23(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__23(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__24(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__24(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__25(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__25(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__26(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__26(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__27(rest, [positive: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__27(rest, acc, stack, context, line, offset) do
    xp_IfExpr__28(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__28(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__29(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__29(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__30(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__30(<<"else", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_IfExpr__31(rest, [] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_IfExpr__30(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"else\"", rest, context, line, offset}
  end

  defp xp_IfExpr__31(rest, acc, stack, context, line, offset) do
    xp_IfExpr__32(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_IfExpr__32(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__33(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__33(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__34(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__34(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_IfExpr__35(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_IfExpr__35(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__36(rest, [negative: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__36(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_IfExpr__37(rest, [if: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_IfExpr__37(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_QuantifiedExpr__0(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__1(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__2(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__2(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__3(
         <<"some", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_QuantifiedExpr__4(rest, [:some] ++ acc, stack, context, comb__line, comb__offset + 4)
  end

  defp xp_QuantifiedExpr__3(
         <<"every", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_QuantifiedExpr__4(rest, [:every] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp xp_QuantifiedExpr__3(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"some\" or string \"every\"", rest, context, line, offset}
  end

  defp xp_QuantifiedExpr__4(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__5(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__5(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__6(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__7(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__7(<<"$", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_QuantifiedExpr__8(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_QuantifiedExpr__7(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"$\"", rest, context, line, offset}
  end

  defp xp_QuantifiedExpr__8(rest, acc, stack, context, line, offset) do
    case(xp_VarName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__9(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__10(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__10(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__11(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__12(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__12(
         <<"in", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_QuantifiedExpr__13(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_QuantifiedExpr__12(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"in\"", rest, context, line, offset}
  end

  defp xp_QuantifiedExpr__13(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__14(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__14(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__15(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__15(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__16(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__16(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__17(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__17(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_QuantifiedExpr__18(
      rest,
      [v_i_e: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_QuantifiedExpr__18(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__19(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__19(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__20(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__20(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__21(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__21(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__23(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_QuantifiedExpr__23(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__24(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__24(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_QuantifiedExpr__25(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_QuantifiedExpr__24(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__25(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__26(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__26(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__27(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_QuantifiedExpr__27(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__28(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__28(<<"$", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_QuantifiedExpr__29(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_QuantifiedExpr__28(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__29(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__30(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__30(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__31(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_QuantifiedExpr__31(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__32(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__32(rest, acc, stack, context, line, offset) do
    case(xp_VarName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__33(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_QuantifiedExpr__33(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__34(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__34(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__35(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_QuantifiedExpr__35(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__36(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__36(
         <<"in", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_QuantifiedExpr__37(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_QuantifiedExpr__36(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__37(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__38(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__38(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__39(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [_, acc | stack] = stack
        xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_QuantifiedExpr__39(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__40(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__40(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__41(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_QuantifiedExpr__22(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_QuantifiedExpr__41(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_QuantifiedExpr__42(
      rest,
      [v_i_e: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_QuantifiedExpr__22(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_QuantifiedExpr__43(rest, acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__42(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_QuantifiedExpr__23(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_QuantifiedExpr__43(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__44(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__44(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__45(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__45(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__46(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__46(
         <<"satisfies", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_QuantifiedExpr__47(rest, [] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp xp_QuantifiedExpr__46(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"satisfies\"", rest, context, line, offset}
  end

  defp xp_QuantifiedExpr__47(rest, acc, stack, context, line, offset) do
    xp_QuantifiedExpr__48(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_QuantifiedExpr__48(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__49(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__49(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_QuantifiedExpr__50(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_QuantifiedExpr__50(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_QuantifiedExpr__51(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_QuantifiedExpr__51(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_QuantifiedExpr__52(
      rest,
      [satisfies: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_QuantifiedExpr__52(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_QuantifiedExpr__53(
      rest,
      [quantified_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_QuantifiedExpr__53(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SimpleLetBinding__0(rest, acc, stack, context, line, offset) do
    xp_SimpleLetBinding__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleLetBinding__1(
         <<"$", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SimpleLetBinding__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SimpleLetBinding__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"$\"", rest, context, line, offset}
  end

  defp xp_SimpleLetBinding__2(rest, acc, stack, context, line, offset) do
    case(xp_VarName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetBinding__3(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleLetBinding__3(rest, acc, stack, context, line, offset) do
    xp_SimpleLetBinding__4(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleLetBinding__4(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetBinding__5(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleLetBinding__5(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleLetBinding__6(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleLetBinding__6(
         <<":=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SimpleLetBinding__7(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_SimpleLetBinding__6(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \":=\"", rest, context, line, offset}
  end

  defp xp_SimpleLetBinding__7(rest, acc, stack, context, line, offset) do
    xp_SimpleLetBinding__8(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleLetBinding__8(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetBinding__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleLetBinding__9(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleLetBinding__10(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleLetBinding__10(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetBinding__11(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleLetBinding__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SimpleLetBinding__12(
      rest,
      [simple_let_binding: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SimpleLetBinding__12(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SimpleLetClause__0(rest, acc, stack, context, line, offset) do
    xp_SimpleLetClause__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleLetClause__1(
         <<"let", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SimpleLetClause__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp xp_SimpleLetClause__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"let\"", rest, context, line, offset}
  end

  defp xp_SimpleLetClause__2(rest, acc, stack, context, line, offset) do
    xp_SimpleLetClause__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleLetClause__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetClause__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleLetClause__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleLetClause__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleLetClause__5(rest, acc, stack, context, line, offset) do
    case(xp_SimpleLetBinding__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetClause__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleLetClause__6(rest, acc, stack, context, line, offset) do
    xp_SimpleLetClause__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleLetClause__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetClause__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleLetClause__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleLetClause__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleLetClause__9(rest, acc, stack, context, line, offset) do
    xp_SimpleLetClause__11(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_SimpleLetClause__11(
         <<",", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SimpleLetClause__12(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SimpleLetClause__11(rest, acc, stack, context, line, offset) do
    xp_SimpleLetClause__10(rest, acc, stack, context, line, offset)
  end

  defp xp_SimpleLetClause__12(rest, acc, stack, context, line, offset) do
    xp_SimpleLetClause__13(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleLetClause__13(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetClause__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_SimpleLetClause__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SimpleLetClause__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleLetClause__15(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleLetClause__15(rest, acc, stack, context, line, offset) do
    case(xp_SimpleLetBinding__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleLetClause__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_SimpleLetClause__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SimpleLetClause__10(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_SimpleLetClause__17(rest, acc, stack, context, line, offset)
  end

  defp xp_SimpleLetClause__16(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_SimpleLetClause__11(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_SimpleLetClause__17(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SimpleLetClause__18(
      rest,
      [simple_let_clause: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SimpleLetClause__18(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_LetExpr__0(rest, acc, stack, context, line, offset) do
    xp_LetExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_LetExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_SimpleLetClause__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_LetExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_LetExpr__2(rest, acc, stack, context, line, offset) do
    xp_LetExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_LetExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_LetExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_LetExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_LetExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_LetExpr__5(<<"return", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_LetExpr__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp xp_LetExpr__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"return\"", rest, context, line, offset}
  end

  defp xp_LetExpr__6(rest, acc, stack, context, line, offset) do
    xp_LetExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_LetExpr__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_LetExpr__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_LetExpr__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_LetExpr__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_LetExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_LetExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_LetExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_LetExpr__11(
      rest,
      [let_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_LetExpr__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SimpleForBinding__0(rest, acc, stack, context, line, offset) do
    xp_SimpleForBinding__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleForBinding__1(
         <<"$", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SimpleForBinding__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SimpleForBinding__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"$\"", rest, context, line, offset}
  end

  defp xp_SimpleForBinding__2(rest, acc, stack, context, line, offset) do
    case(xp_VarName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForBinding__3(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleForBinding__3(rest, acc, stack, context, line, offset) do
    xp_SimpleForBinding__4(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleForBinding__4(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForBinding__5(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleForBinding__5(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleForBinding__6(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleForBinding__6(
         <<"in", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SimpleForBinding__7(rest, [] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp xp_SimpleForBinding__6(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"in\"", rest, context, line, offset}
  end

  defp xp_SimpleForBinding__7(rest, acc, stack, context, line, offset) do
    xp_SimpleForBinding__8(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleForBinding__8(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForBinding__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleForBinding__9(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleForBinding__10(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleForBinding__10(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForBinding__11(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleForBinding__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SimpleForBinding__12(
      rest,
      [simple_for_binding: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SimpleForBinding__12(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_SimpleForClause__0(rest, acc, stack, context, line, offset) do
    xp_SimpleForClause__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleForClause__1(
         <<"for", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SimpleForClause__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp xp_SimpleForClause__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"for\"", rest, context, line, offset}
  end

  defp xp_SimpleForClause__2(rest, acc, stack, context, line, offset) do
    xp_SimpleForClause__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleForClause__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForClause__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleForClause__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleForClause__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleForClause__5(rest, acc, stack, context, line, offset) do
    case(xp_SimpleForBinding__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForClause__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleForClause__6(rest, acc, stack, context, line, offset) do
    xp_SimpleForClause__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleForClause__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForClause__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_SimpleForClause__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleForClause__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleForClause__9(rest, acc, stack, context, line, offset) do
    xp_SimpleForClause__11(
      rest,
      [],
      [{rest, acc, context, line, offset} | stack],
      context,
      line,
      offset
    )
  end

  defp xp_SimpleForClause__11(
         <<",", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    xp_SimpleForClause__12(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_SimpleForClause__11(rest, acc, stack, context, line, offset) do
    xp_SimpleForClause__10(rest, acc, stack, context, line, offset)
  end

  defp xp_SimpleForClause__12(rest, acc, stack, context, line, offset) do
    xp_SimpleForClause__13(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_SimpleForClause__13(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForClause__14(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_SimpleForClause__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SimpleForClause__14(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_SimpleForClause__15(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_SimpleForClause__15(rest, acc, stack, context, line, offset) do
    case(xp_SimpleForBinding__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_SimpleForClause__16(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_SimpleForClause__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_SimpleForClause__10(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_SimpleForClause__17(rest, acc, stack, context, line, offset)
  end

  defp xp_SimpleForClause__16(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_SimpleForClause__11(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_SimpleForClause__17(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_SimpleForClause__18(
      rest,
      [simple_for_clause: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_SimpleForClause__18(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ForExpr__0(rest, acc, stack, context, line, offset) do
    xp_ForExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ForExpr__1(rest, acc, stack, context, line, offset) do
    case(xp_SimpleForClause__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForExpr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ForExpr__2(rest, acc, stack, context, line, offset) do
    xp_ForExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ForExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ForExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ForExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ForExpr__5(<<"return", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ForExpr__6(rest, [] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp xp_ForExpr__5(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"return\"", rest, context, line, offset}
  end

  defp xp_ForExpr__6(rest, acc, stack, context, line, offset) do
    xp_ForExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ForExpr__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForExpr__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ForExpr__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ForExpr__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ForExpr__9(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ForExpr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ForExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ForExpr__11(
      rest,
      [for_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ForExpr__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ExprSingle__0(rest, acc, stack, context, line, offset) do
    xp_ExprSingle__14(
      rest,
      [],
      [{rest, context, line, offset}, acc | stack],
      context,
      line,
      offset
    )
  end

  defp xp_ExprSingle__2(rest, acc, stack, context, line, offset) do
    case(xp_OrExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ExprSingle__3(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ExprSingle__3(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ExprSingle__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ExprSingle__4(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ExprSingle__2(rest, [], stack, context, line, offset)
  end

  defp xp_ExprSingle__5(rest, acc, stack, context, line, offset) do
    case(xp_IfExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ExprSingle__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ExprSingle__4(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ExprSingle__6(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ExprSingle__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ExprSingle__7(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ExprSingle__5(rest, [], stack, context, line, offset)
  end

  defp xp_ExprSingle__8(rest, acc, stack, context, line, offset) do
    case(xp_QuantifiedExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ExprSingle__9(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ExprSingle__7(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ExprSingle__9(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ExprSingle__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ExprSingle__10(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ExprSingle__8(rest, [], stack, context, line, offset)
  end

  defp xp_ExprSingle__11(rest, acc, stack, context, line, offset) do
    case(xp_LetExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ExprSingle__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ExprSingle__10(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ExprSingle__12(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ExprSingle__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ExprSingle__13(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_ExprSingle__11(rest, [], stack, context, line, offset)
  end

  defp xp_ExprSingle__14(rest, acc, stack, context, line, offset) do
    case(xp_ForExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ExprSingle__15(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ExprSingle__13(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ExprSingle__15(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_ExprSingle__1(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_ExprSingle__1(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Expr__0(rest, acc, stack, context, line, offset) do
    xp_Expr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Expr__1(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Expr__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Expr__2(rest, acc, stack, context, line, offset) do
    xp_Expr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Expr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Expr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Expr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Expr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Expr__5(rest, acc, stack, context, line, offset) do
    xp_Expr__7(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp xp_Expr__7(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Expr__8(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Expr__7(rest, acc, stack, context, line, offset) do
    xp_Expr__6(rest, acc, stack, context, line, offset)
  end

  defp xp_Expr__8(rest, acc, stack, context, line, offset) do
    xp_Expr__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Expr__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Expr__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_Expr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Expr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Expr__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Expr__11(rest, acc, stack, context, line, offset) do
    case(xp_ExprSingle__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Expr__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_Expr__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Expr__6(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_Expr__13(rest, acc, stack, context, line, offset)
  end

  defp xp_Expr__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_Expr__7(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_Expr__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Expr__14(rest, [expr: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_Expr__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_EnclosedExpr__0(rest, acc, stack, context, line, offset) do
    xp_EnclosedExpr__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_EnclosedExpr__1(<<"{", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_EnclosedExpr__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_EnclosedExpr__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"{\"", rest, context, line, offset}
  end

  defp xp_EnclosedExpr__2(rest, acc, stack, context, line, offset) do
    xp_EnclosedExpr__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_EnclosedExpr__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_EnclosedExpr__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_EnclosedExpr__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_EnclosedExpr__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_EnclosedExpr__5(rest, acc, stack, context, line, offset) do
    case(xp_Expr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_EnclosedExpr__6(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_EnclosedExpr__6(rest, acc, stack, context, line, offset) do
    xp_EnclosedExpr__7(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_EnclosedExpr__7(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_EnclosedExpr__8(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_EnclosedExpr__8(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_EnclosedExpr__9(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_EnclosedExpr__9(<<"}", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_EnclosedExpr__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_EnclosedExpr__9(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"}\"", rest, context, line, offset}
  end

  defp xp_EnclosedExpr__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_EnclosedExpr__11(
      rest,
      [enclosed_expr: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_EnclosedExpr__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_FunctionBody__0(rest, acc, stack, context, line, offset) do
    xp_FunctionBody__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_FunctionBody__1(rest, acc, stack, context, line, offset) do
    case(xp_EnclosedExpr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_FunctionBody__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_FunctionBody__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_FunctionBody__3(
      rest,
      [function_body: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_FunctionBody__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_Param__0(rest, acc, stack, context, line, offset) do
    xp_Param__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Param__1(<<"$", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_Param__2(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_Param__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \"$\"", rest, context, line, offset}
  end

  defp xp_Param__2(rest, acc, stack, context, line, offset) do
    case(xp_EQName__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Param__3(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Param__3(rest, acc, stack, context, line, offset) do
    xp_Param__4(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_Param__4(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Param__5(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_Param__5(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Param__6(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_Param__6(rest, acc, stack, context, line, offset) do
    xp_Param__10(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp xp_Param__8(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Param__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Param__9(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    xp_Param__8(rest, [], stack, context, line, offset)
  end

  defp xp_Param__10(rest, acc, stack, context, line, offset) do
    case(xp_TypeDeclaration__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_Param__11(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_Param__9(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_Param__11(rest, acc, [_, previous_acc | stack], context, line, offset) do
    xp_Param__7(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp xp_Param__7(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_Param__12(rest, [param: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_Param__12(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_ParamList__0(rest, acc, stack, context, line, offset) do
    xp_ParamList__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParamList__1(rest, acc, stack, context, line, offset) do
    case(xp_Param__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParamList__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ParamList__2(rest, acc, stack, context, line, offset) do
    xp_ParamList__3(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParamList__3(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParamList__4(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_ParamList__4(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ParamList__5(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ParamList__5(rest, acc, stack, context, line, offset) do
    xp_ParamList__7(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp xp_ParamList__7(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    xp_ParamList__8(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp xp_ParamList__7(rest, acc, stack, context, line, offset) do
    xp_ParamList__6(rest, acc, stack, context, line, offset)
  end

  defp xp_ParamList__8(rest, acc, stack, context, line, offset) do
    xp_ParamList__9(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_ParamList__9(rest, acc, stack, context, line, offset) do
    case(xp_S__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParamList__10(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        [acc | stack] = stack
        xp_ParamList__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ParamList__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_ParamList__11(rest, [] ++ acc, stack, context, line, offset)
  end

  defp xp_ParamList__11(rest, acc, stack, context, line, offset) do
    case(xp_Param__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_ParamList__12(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        xp_ParamList__6(rest, acc, stack, context, line, offset)
    end
  end

  defp xp_ParamList__6(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    xp_ParamList__13(rest, acc, stack, context, line, offset)
  end

  defp xp_ParamList__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    xp_ParamList__7(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp xp_ParamList__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    xp_ParamList__14(
      rest,
      [param_list: :lists.reverse(user_acc)] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp xp_ParamList__14(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp xp_XPath__0(rest, acc, stack, context, line, offset) do
    xp_XPath__1(rest, [], [acc | stack], context, line, offset)
  end

  defp xp_XPath__1(rest, acc, stack, context, line, offset) do
    case(xp_Expr__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xp_XPath__2(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xp_XPath__2(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    xp_XPath__3(rest, [xpath: :lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp xp_XPath__3(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  @spec xpath(binary, keyword) ::
          {:ok, [term], rest, context, line, byte_offset}
          | {:error, reason, rest, context, line, byte_offset}
        when line: {pos_integer, byte_offset},
             byte_offset: pos_integer,
             rest: binary,
             reason: String.t(),
             context: map()
  defp xpath(binary, opts \\ []) when is_binary(binary) do
    context = Map.new(Keyword.get(opts, :context, []))
    byte_offset = Keyword.get(opts, :byte_offset, 0)

    line =
      case(Keyword.get(opts, :line, 1)) do
        {_, _} = line ->
          line

        line ->
          {line, byte_offset}
      end

    case(xpath__0(binary, [], [], context, line, byte_offset)) do
      {:ok, acc, rest, context, line, offset} ->
        {:ok, :lists.reverse(acc), rest, context, line, offset}

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xpath__0(rest, acc, stack, context, line, offset) do
    case(xp_XPath__0(rest, acc, [], context, line, offset)) do
      {:ok, acc, rest, context, line, offset} ->
        xpath__1(rest, acc, stack, context, line, offset)

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp xpath__1(<<""::binary>>, acc, stack, context, comb__line, comb__offset) do
    xpath__2("", [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp xpath__1(rest, _acc, _stack, context, line, offset) do
    {:error, "expected end of string", rest, context, line, offset}
  end

  defp xpath__2(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end
end
