defmodule TwoThree do
    def insert(key, value, {}) do
        {:leaf, key, value}
    end
    def insert(key, value, {:leaf, k, val}) do
       if key<k do 
        {:two, key, {:leaf, key, value},{:leaf, k, val}}
       else 
        {:two, k,{:leaf, k, val}, {:leaf, key, value}}
       end
    end
    def insert(key, value, {:two, k, {:leaf, k1, val1},{:leaf, k2, val2}}) do
        cond do
            key < k -> {:three, key, k, {:leaf, key, value}, {:leaf, k1, val1},{:leaf, k2, val2}}
            key == k -> {:two, k, {:leaf, key, value},{:leaf, k2, val2}} # insert(key, value, {:leaf, k2, val2) when key == 
            key > k -> cond do
                key==k2 -> {:two, k,{:leaf, k1, val1},{:leaf, key, value}} 
                key < k2 -> {:three, k, key, {:leaf, k1, val1},{:leaf, key, value}, {:leaf, k2, val2}}
                key>k2 -> {:three, k, k2, {:leaf, k1, val1}, {:leaf, k2, val2}, {:leaf, key, value}}
            end    
        end
        
    end
    def insert(key, value, {:three, k1, k2, {:leaf, key1, value1}, {:leaf, key2, value2}, {:leaf, key3, value3}}) do
        cond do
            key==k1 -> {:three, k1, k2, {:leaf, key1, value}, {:leaf, key2, value2}, {:leaf, key3, value3}}
            key<k1 -> {:four, key, k1, k2, {:leaf, key, value},{:leaf, key1, value1}, {:leaf, key2, value2}, {:leaf, key3, value3}}
            key<=k2 && key>k1 -> cond do
                key == key2 -> {:three, k1, k2, {:leaf, key1, value1}, {:leaf, key2, value}, {:leaf, key3, value3}}
                key < key2 -> {:four, k1, key, key2, {:leaf, key1, value1}, {:leaf, key, value} ,{:leaf, key2, value2}, {:leaf, key3, value3}}
                key > key2 -> {:four, k1, key, key2, {:leaf, key1, value1} ,{:leaf, key2, value2}, {:leaf, key, value}, {:leaf, key3, value3}}
            end
            key == key3 -> {:three, k1, k2, {:leaf, key1, value}, {:leaf, key2, value2}, {:leaf, key3, value}}
            key > key3 -> {:four, k1, k2, key3, {:leaf, key1, value1}, {:leaf, key2, value2}, {:leaf, key3, value3},{:leaf, key, value}}
            key < key3 -> {:four, k1, k2, key, {:leaf, key1, value1}, {:leaf, key2, value2},{:leaf, key, value}, {:leaf, key3, value3}}
        end
    end

    def insert(key, value, {:two, k, left, right}) do
        cond do
            key <= k-> 
                case insert(key, value, left)  do
                {:four , q1, q2, q3, l, m1, m2, r} -> {:three, q2, k, {:two, q1, l, m1}, {:two, q3, m2, r}, right}
                updated -> {:two, k, updated, right}     
                end
    
            true -> 
                case insert(key, value, right) do
                    {:four , q1, q2, q3, l, m1, m2, r} -> {:three, k, q2, left, {:two, q1, l, m1}, {:two, q3, m2, r}}
                    updated -> {:two, k, left, updated}
                end
        end
    end

    def test(k ,v) do
        tree = {:two, 5, 
                    {:three, 3, 4, 
                        {:leaf, 3,"c"}, 
                        {:leaf, 4, "d"}, 
                        {:leaf, 5, "e"}},
                    {:three, 7, 8, 
                        {:leaf,7,"g"}, 
                        {:leaf, 8, "h"}, 
                        {:leaf, 9, "i"}}}
        insert(k, v, tree)
    end
end