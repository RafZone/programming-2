defmodule Vector do
    def smul({x1, x2, x3}, s) do
        {s*x1, x2*s, x3*s}
    end

    def sub({x1, x2, x3}, {y1, y2, y3}) do 
        {x1 - y1, x2 - y2, x3 - y3}
    end

    def add({x1, x2, x3}, {y1, y2, y3}) do
        {x1 + y1, x2 + y2, x3 + y3}
    end

    def norm({x1, x2, x3}) do
       x= (x1 * x1) + (x2 * x2) + (x3 * x3)
        :math.sqrt(x)
    end

    def dot({x1, x2, x3}, {y1, y2, y3}) do 
        {(x1 * y1) + (x2 * y2) + (x3 * y3)}
    end  

    def normalize(x) do
        {x1,x2,x3} = x
        nor = norm({x1, x2, x3})
        {x1/nor, x2/nor, x3/nor}
    end
end