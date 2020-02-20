defmodule Calculate do
    
    def eval({:int, n}) do
        n
    end
    def eval({:add, a, b}) do
        eval(a) + eval(b)
    end
    def eval({:sub, a, b}) do eval(a) - eval(b) end
    def eval({:mul, a, b}) do eval(a) * eval(b) end
    def eval({:var, name}, bindings) do lookup(name, bindings) end
    def eval({:add, a, b}, bindings) do 
       x={:int, eval(a , bindings)}
       y= {:int, eval(b, bindings)}
       eval({:add, x, y})
    end

    def lookup(var, [{:bind, var, value} | _] ) do value end
    def lookup(var, [_ | rest]) do
    lookup(var, rest)
    end
#Calc.eval({:add, {:var, :x}, {:var, :y}}, [{:bind, :x, 5}, {:bind, :y, 2}])
end