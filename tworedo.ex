defmodule Two do
    def search(_, :nill) do
        :empty
    end
    def search(key, {:leaf, key, value}) do
        {:yes, value}
    end
    def search(_, {:leaf, _, _}) do
        :no
    end
    def search(key, {:two, k, left, _}) when key <= k do
        search(key, left)
    end
    def search(key, {:two, _, _, right}) do
        search(key, right)
    end
    def search(key, {:three, k1, _, left, _, _}) when key<= k1 do
        search(key, left)
    end
    def search(key, {:three, _, k2, _, middle, _}) when key <= k2 do
        search(key, middle)
    end
    def search(key, {:three, _, _ , _, _, right}) do
        search(key, right)
    end

     def test(k) do
        tree = {:two, 5, 
                    {:three, 3, 4, 
                        {:leaf, 3,"c"}, 
                        {:leaf, 4, "d"}, 
                        {:leaf, 5, "e"}},
                    {:three, 7, 8, 
                        {:leaf,7,"g"}, 
                        {:leaf, 8, "h"}, 
                        {:leaf, 9, "i"}}}
        search(k, tree)
    end

end