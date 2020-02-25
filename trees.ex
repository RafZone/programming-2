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

    def testIns() do 
        tree={:node, 3, {:leaf, 2}, {:node, 4, :nil, {:leaf, 5}}}
        insert(3.5, tree)
    end

    def insert(e, :nil) do {:leaf, e} end
    def insert(e, {:leaf, n}) do
        if e > n do
            {:node, n, :nil, {:leaf, e}}
        else
            {:node, n, {:leaf, e}, :nil}
        end
    end

    def insert(e, {:node, n, left, right}) do 
        cond do
            e > n -> {:node, n, left, insert(e, right)}
            true ->  {:node, n, insert(e, left), right}  
        end
    end

    def hib({:node, e, left, _}) do
        if left != :nil do 
            hib(left)
        else 
            e
        end
    end
    def hib({:leaf, e}) do
        e
    end
    def hib(:nil) do :nil end 

    def delete(:nil, _) do :nil end
    def delete(e, {:leaf, e}) do :nil end
    #  def delete(_, {:node, e, :nil, :nil }) do {:leaf, e} end
    #delete(hib(right))
    def delete(e, {:node, e, left, right}) do
        x=hib(right)
        m = {:node, x, left, delete(x, right)}
        cond do
            m ==:nil -> {:leaf, e}
            true -> m     
        end
    end
    
    def delete(e, {:node, n, left, right}) do
        cond do
            e < n -> {:node, n, delete(e, left), right}
            e > n -> {:node, n, left, delete(e, right)}
        end
    end  

    def testDel(x) do 
        tree={:node, 3, {:leaf, 2}, {:node, 4, :nil, :nil}}
        delete(x, tree)
    end  
    
end