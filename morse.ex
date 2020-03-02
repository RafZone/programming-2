defmodule Morse do

def decode(signal, table)  do
    decode(signal, table, [], [])
end

def decode([], _, _, longlist) do Enum.reverse(longlist) end
def decode([char|rest], table, msg, longlist)do
if char != 32 do
    decode(rest, table, [char|msg], longlist)
else
    decode(rest, table, [], [decodeChar(Enum.reverse(msg), table)|longlist])
end
end

def decodeChar([], {:node, char, _, _}) do char end
def decodeChar([h|t], table) do
    {:node, _, left, right} = table #dot/short=45, dash/long=46
    if h == 45 do 
        decodeChar(t, left)
    else 
        decodeChar(t, right)
    end
end
defp fill(codes) do
  fill(codes, [], 0)
end
defp fill([], newlist, _) do
    newlist
end
defp fill([h|t], newlist, pos) do
    {char, signal}=h
    cond do
        newlist == [] and char !=0 -> fill([h|t], [:na|newlist], pos + 1)
        char - pos > 1 -> fill([h|t], [:na|newlist], pos + 1)
        true -> fill(t, [signal|newlist], pos + 1)  
    end
end
# ecoding
# defp lookup(char, table) do
#   encoding = List.keyfind(table, char, 0)
#   elem(encoding, 1)
# end

# def encode(text) do
#   table = encode_table()
#   encode(text, [], table)
# end

# def encode([], _), do: []
# def encode([char | message], table) do 
#   code = lookup(char, table),
#   append(code, encode(message, table))
# end
defp encode_table() do
  # codes()
  # |> fill()
  # |> List.to_tuple
  list=fill(codes())
  List.to_tuple(Enum.reverse(list))
end
defp decode_table do
  {:node, :na,
    {:node, 116,
      {:node, 109,
        {:node, 111,
          {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
          {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
        {:node, 103,
          {:node, 113, nil, nil},
          {:node, 122,
            {:node, :na, {:node, 44, nil, nil}, nil},
            {:node, 55, nil, nil}}}},
      {:node, 110,
        {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
        {:node, 100,
          {:node, 120, nil, nil},
          {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
    {:node, 101,
      {:node, 97,
        {:node, 119,
          {:node, 106,
            {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
            nil},
          {:node, 112,
            {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
            nil}},
        {:node, 114,
          {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
          {:node, 108, nil, nil}}},
      {:node, 105,
        {:node, 117,
          {:node, 32,
            {:node, 50, nil, nil},
            {:node, :na, nil, {:node, 63, nil, nil}}},
          {:node, 102, nil, nil}},
        {:node, 115,
          {:node, 118, {:node, 51, nil, nil}, nil},
          {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
end
defp codes do
  [{32, '..--'},
    {37,'.--.--'},
    {44,'--..--'},
    {45,'-....-'},
    {46,'.-.-.-'},
    {47,'.-----'},
    {48,'-----'},
    {49,'.----'},
    {50,'..---'},
    {51,'...--'},
    {52,'....-'},
    {53,'.....'},
    {54,'-....'},
    {55,'--...'},
    {56,'---..'},
    {57,'----.'},
    {58,'---...'},
    {61,'.----.'},
    {63,'..--..'},
    {64,'.--.-.'},
    {97,'.-'},
    {98,'-...'},
    {99,'-.-.'},
    {100,'-..'},
    {101,'.'},
    {102,'..-.'},
    {103,'--.'},
    {104,'....'},
    {105,'..'},
    {106,'.---'},
    {107,'-.-'},
    {108,'.-..'},
    {109,'--'},
    {110,'-.'},
    {111,'---'},
    {112,'.--.'},
    {113,'--.-'},
    {114,'.-.'},
    {115,'...'},
    {116,'-'},
    {117,'..-'},
    {118,'...-'},
    {119,'.--'},
    {120,'-..-'},
    {121,'-.--'},
    {122,'--..'}]
end

def test() do
  #   message1 = '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... '
  #   message2 = '.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .---- '
  #  decode(message2, decode_table())
   table = encode_table()
    
end

end