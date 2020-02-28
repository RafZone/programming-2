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
     def huffman([h|t]) do
       huffman(t, [h])
    end
    def huffman([], tree) do tree end
    def huffman([h1|t1], [h2|t2] = tree) do
        # minOrder=minPQ(t, [h])
        # [minh|mint]=minOrder
        # huffman(t, [maketree(minh, mint)| tree])
        #maketree=[{{c1, c2}, f1 + f2}|sorted_tail]
        # sorted=minPQ(t, [h])
        # [hsorted|tsorted]=sorted
        # huffman(maketree(hsorted, tsorted))
        {c1, f1}=h1
        {c2, f2}=h2

        cond do
            f1 < f2 -> huffman(t1, minPQ(t2, [maketree(h1, h2)]))
            true  -> huffman(t1, sorted=minPQ(t2, [maketree(h2, h1)]))
        end
    end
    def maketree({c1, f1}, []) do
        {c1, f1}
    end
    def maketree({c1, f1}, {c2, f2}) do
        {{c1, c2}, f1 + f2}
    end
    def testmin() do
        list=freq('this is something that we should encode')
        huffman(list)
        
    end


    # def encode_table(tree) do
    # # To implement...
    # end
    # def decode_table(tree) do #.... 
    
    # end
    # def encode(text, table) do
    #     # To implement...
    # end
    # def decode(seq, tree) do
    #     # To implement...
    # end


end