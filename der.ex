defmodule Der do
    @type number() :: integer() | float()
    @type literal() :: {:const, number()}
                    |  {:const, atom()}
                    |  {:var, atom()}

    @type expr() :: {:add, expr(), expr()} 
            | {:mul, expr(), expr()} 
            | literal()

    def deriv({:const, _}, _) do #{:const, 2} ,  v
        {:const, 0}
    end

    # def deriv({:var, v}, v) do # {:var, :x},  v
    #     {:mul, deriv({:var, v}, v)}
    # end

    def deriv({:var, _}, _) do
        {:const, 1}
    end

    def deriv({:mul, e1, e2}, v) do #{:mul, {:const, 2}, {:var, :x}}, v
        # cons = deriv(e1, v) #{:const, 2} ,  v
        # var = deriv(e2, v) # {:var, :x},  v
        # {cons, var}
        {:add, {:mul, deriv(e1, v),e2}, {:mul, e1, deriv(e2, v)}}
    end

    def deriv({:add, e1, e2}, v) do
        a = deriv(e1, v)
        b = deriv(e2, v)
        {a, b}
    end
# {:add, {:mul, {:const, 2}, {:var, :x}}, {:const, 3}} in this case v is :x (meaning derive with respect to x)

end