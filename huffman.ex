defmodule Huff do
    def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
    end
    def text() do
        'this is something that we should encode'
    end
    # def test do
    #     sample = sample()
    #     tree = tree(sample)
    #     encode = encode_table(tree)
    #     decode = decode_table(tree)
    #     text = text()
    #     seq = encode(text, encode)
    #     decode(seq, decode)
    # end
    # def tree(sample) do
    #     freq = freq(sample)
    #     huffman(freq)
    # end
    def freq(sample) do
        freq(sample, [])
    end
    def freq([], freq) do
        freq
    end
    def freq([char | rest], freqlist) do
        cond do
            freqlist == [] -> freq(rest , [{char, 1}|[]])
            freqlist != [] -> freq(rest, increment(char, freqlist))
        end
    end
    def increment(char, []) do
        [{char, 1}]
    end
    def increment(char, [h|t]) do
        {element, sum} = h
        cond do
            element == char -> [{element, sum + 1}|t]
            element != char -> [h|increment(char, t)]
        end
    end
    #MinPQ
    def minPQ([],sorted) do 
        sorted
    end
    def minPQ([h|t], []) do [h] end
    def minPQ([h|t], sorted = [sh|st]) do 
        {char, freq} = h
        {c, f} = sh
        cond do
            freq <= f -> minPQ(t, [h|sorted])
            true -> minPQ(t, [sh|minPQ([h], st)])
        end
        
    end
    def huffman([h|[]]) do h end
    def huffman([h|t]) do
        sorted = minPQ( t , [h])
        [h1sorted,h2sorted|tsorted] = sorted
        huffman([maketree(h1sorted, h2sorted)|tsorted])
    end
    def maketree({c1, f1}, []) do
        {c1, f1}
    end
    # def maketree({{c00, c01}, f},{{c1, c2},  f2}) do
    #     {{c00, c01, f},{c1, c2, f2}, f+f2}
    # end
    def maketree({c1, f1}, {c2, f2}) do
        if f1 < f2 do 
            {{c1, c2}, f1 + f2}
        else 
            {{c2, c1}, f1 + f2}
        end
        
    end
    
    
    def testmin() do
    
        list=freq(sample())
        table=encode_table(huffman(list), list)
        seq=encode(text(), table, [])
        decode(seq, table)
        #[{{101=e, {100=d, {99=c, {97=a, 98=b}}}}, 55}]
        #[{a, b, 14}, {c, d, }]
    end


    def encode_table(tree, list) do
        chars=char(list, []) #1. list of chars (table)
        
        #2. go through path of tree and encode table
        codes=traverse(elem(tree, 0), chars, []) #list of codes for each char

    end
    def traverse(_ , [], codelist) do codelist end
    def traverse(tree ,[lh|lt], codelist) do
        traverse(tree, lt, [{lh, Enum.reverse(code(lh, tree, []))}|codelist])
    end
    
    # def code(_, [], charcode ) do charcode end
    def code(a, a, charcode)  do [0|charcode] end #left of root, first element in tree
    def code(a, b,_) when is_integer(a) and is_integer(b) do :no end
    def code(a, {a, _}, charcode) do [0|charcode] end
    def code(a, {_, a}, charcode) do [1|charcode] end
    def code(a, {left, right}, charcode) do
        #list = [{97, 5}, {98, 9}, {99, 12}, {100, 13}, {101, 16}, {102, 45}]
        #tree= {102, {{99, 100}, {{97, 98}, 101}}}
        #when done table= [{97, [1, 1,0,0]}, {98, [1, 1,0,1]}, {99, [1,0,0]}, {100, [1,0,1]}, {101, [1, 1, 1]},
        #{102, [0]}]
        case code(a, left , [0|charcode]) do
            :no -> code(a, right, [1|charcode])
            _ -> code(a, left , [0|charcode])
        end
    end

    def char([], newlist) do newlist end
    def char([h|t], newlist) do
        {element, _} = h
        char(t, [element|newlist])
    end
    def encode([], table, seq) do List.flatten(Enum.reverse(seq)) end
    def encode(text, table, seq) do
        #1. ta in text (the short charlist) som ska encodas till en sekvens av 1:or och 0:or
        #2. sök igenom tabllen och encoda
        [h|t]=text
        encode(t, table, [findchar(h, table)|seq])
    end
    def findchar(a, []) do
        :no
    end
    def findchar(a, [h|t]) do
        {c, code}=h
        cond do
            a == c -> code
            true -> findchar(a, t)
        end
    end
    def decode([], _) do
        []
    end
    def decode(seq, table) do
        {char, rest} = decode_char(seq, 1, table)
        [char | decode(rest, table)]
    end
    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case List.keyfind(table, code, 1) do
            {a, charcode}  -> {a, rest}
            nil -> decode_char(seq, n + 1, table)
        #     nil ->
        # decode_char(..., ..., table)
        end
    end
    # def decode_table(tree) do #.... 
    
    # end
    
    # def decode(seq, tree) do
    #     # To implement...
    # end
#text= [{97, [1, 1,0,0]}, {98, [1, 1,0,1]}, {99, [1,0,0]}, {100, [1,0,1]}, {101, [1, 1, 1]},
        #{102, [0]}] 
# [ this is sample
#   {116, [1, 1, 0, 0]},
#   {104, [1, 0, 1, 0, 1]},
#   {101, [1, 1, 1, 0]},
#   {32, [0, 1]},
#   {113, [1, 0, 0, 0, 0, 1, 0]},
#   {117, [1, 0, 1, 1, 0]},
#   {97, [1, 1, 1, 1, 1]},
#   {122, [1, 0, 0, 0, 1, 1, 1, 1]},
#   {121, [1, 1, 0, 1, 0, 0]},
#   {100, [1, 0, 0, 0, 0, 0]},
#   {103, [1, 0, 0, 0, 1, 1, 0]},
#   {10, [1, 0, 0, 0, 1, 0]}
# ]
# 'aaaaabbbbbbbbbccccccccccccdddddddddddddeeeeeeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffff'

end