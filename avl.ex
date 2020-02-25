defmodule Avl do
#AVL property: no subtree on one side from a root can have a depth longer than one from the other
#in case of AVL property violation: (only, grandchild nodes can violate property)
#A single rotations:
#1. left rotation


### {parent
    #         childA
    #         childB{
    #              grandild}
    # }


    def insert(tree, key, value) do
        case insrt(tree, key, value) do
            {:inc, q} -> q
            {:ok, q} -> q
        end
    end

    #insert to empty tree (special case nr 1)
    defp insrt(nil, key, value) do
        {:inc, {:node, key, value, 0, nil, nil}}
    end 

    #the key found in root of tree (specail case nr 2)
    defp insrt({:node, key, _, f, a, b}, key, value) do
        {:ok, {:node, key, value, f, a, b}}
    end

    #go down left when tree diff is at 0, and kk < rk
    defp insrt({:node, rk, rv, 0, a, b}, kk, kv) when kk < rk do
        case insrt(a, kk, kv) do
            {:inc, q} ->
                {:inc, {:node, rk, rv, -1, q, b}}
            {:ok, q} ->
                {:ok, {:node, rk, rv, 0, q, b}}
        end
    end
    # The right-side version:
    defp insrt({:node, rk, rv, 0, a, b}, kk, kv) when kk > rk do
        case insrt(b, kk, kv) do
            {:inc, q} ->
                {:inc, {:node, rk, rv, +1, a, q}}
            {:ok, q} ->
                {:ok, {:node, rk, rv, 0, a, q}}
        end
    end

    #go down left when diff is +1 and 
    defp insrt({:node, rk, rv, +1, a, b}, kk, kv) when kk < rk do
        case insrt(a, kk, kv) do
        {:inc, q} ->
            {:ok, {:node, rk, rv, 0, q, b}}
        {:ok, q} ->
            {:ok, {:node, rk, rv, +1, q, b}}
        end
    end
    #the right-side version:
     defp insrt({:node, rk, rv, -1, a, b}, kk, kv) when kk > rk do
        case insrt(b, kk, kv) do
        {:inc, q} ->
            {:ok, {:node, rk, rv, 0, a, q}}
        {:ok, q} ->
            {:ok, {:node, rk, rv, -1, a, q}}
        end
    end
    #left violation of AVL property
    defp insrt({:node, rk, rv, -1, a, b}, kk, kv) when kk < rk do
        case insrt(a, kk, kv) do
        {:inc, q} ->
            {:ok, rotate({:node, rk, rv, -2, q, b})}
        {:ok, q} ->
            {:ok, {:node, rk, rv, -1, q, b}}
        end
    end
    #the right-side version:
    defp insrt({:node, rk, rv, +1, a, b}, kk, kv) when kk > rk do
        case insrt(b, kk, kv) do
        {:inc, q} ->
            {:ok, rotate({:node, rk, rv, +2, a, q})}
        {:ok, q} ->
            {:ok, {:node, rk, rv, +1, a, q}}
        end
    end

    #rotations: single rotation
    defp rotate({:node, xk, xv, -2, {:node, yk, yv, -1, a, b}, c}) do
        {:node, yk, yv, 0, a, {:node, xk, xv, 0, b, c}}        
    end

    defp rotate({:node, xk, xv, +2, a, {:node, yk, yv, +1, b, c}}) do
        {:node, yk, yv, 0, {:node, xk, xv, 0, a, b}, c}
    end

end