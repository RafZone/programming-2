defmodule Splay do
    
    def update(nil, key, value) do
        {:node, key, value, :nil, :nil}
    end

    def update({:node, key, _, a, b}, key, value) do
        {:node, key, value, a, b}
    end

    def update({:node, rk, rv, zig, c}, key, value) when key < rk do
        # The general rule where we will do the Zig transformation.
        {:splay, _, a, b} = splay(zig, key)
        {:node, key, value, a, {:node, rk, rv, b, c}}
    end

    def update({:node, rk, rv, a, zag}, key, value) when key >= rk do
        # The general rule where we will do the Zag transformation.
        {:splay, _, b, c} = splay(zag, key)
        {:node, key, value , {:node, rk, rv , a, b }, c }
    end
    #2 functions fro root. if key is empty and if key is found in root
    defp splay(nil, _) do
        {:splay, :na, :nil, :nil}
    end

    defp splay({:node, key, value, a, b}, key) do
        {:splay, value , a, b}
    end

    def test(k, v) do
        update({:node, rk, rv, zig, c}, k, v)
    end

end