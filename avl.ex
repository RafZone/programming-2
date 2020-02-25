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

end