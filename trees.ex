defmodule Trees do
    #unordered
    def mem(_, :nil) do :no end
    def mem(q, {:leaf, q}) do :yes end
    def mem(_, {:leaf, _}) do :no end

    def mem(q , {:node, q, _, _}) do :yes end

    def mem(q , {:node, _ , left, right }) do
        IO.puts " ******"
        case mem(q, left) do
            :yes -> :yes
            :no ->
                IO.puts " ---------- "
                mem(q, right) 
                #IO.puts " ///////"
                
        end
    end

    def test() do
        tee= {:node, 1, {:node, 3, {:leaf, 8}, {:leaf, 4}}, {:node , 7, {:leaf, 21}, {:leaf, 5}}}
        mem(99, tee)
    end

    #ordered
    def member(_, :nil) do :no end
    def member(e , {:leaf, e}) do :yes end
    def member(_, {:leaf, _} ) do :no end

    def member(e, {:node, e, _, _}) do :yes end

    def member(e, {:node, n, left, right}) do
        cond    do
            e < n -> member(e, left)
            true -> member(e, right)
        end
    end

    def testOrd(x) do
        tee= {:node, 8, {:node, 5, {:leaf, 4}, {:leaf, 7}}, {:node , 12, {:leaf, 10}, {:leaf, 15}}}
        member(x, tee)
    end


end