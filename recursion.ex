defmodule Recursion do
    ###########£###prod###########
    def prod(1, n) do
        n
    end
    def prod(m, 1) do
        m
    end
    def prod(m, n)  when m < 0 and n > 0 do
        IO.puts "#{m} #{n}"
        m + prod(m, n-1)
       
    end
    def prod(m, n) when n < 0 and m > 0 do
        prod(n, m)
    end
    def prod(m, n) when n < 0 and m < 0 do
        prod(0-m,0-n)
    end
    #when both m and n are negative we need to change them to binary, do twos complement and change them back
    # and then using those values call the function below or we can use the formula (0-x)
    def prod(m, n) do
        n + prod(m-1, n)
    end

    ###############power###########
    def pwr(_, 0) do 1 end
    def pwr(m,n)do
        m*pwr(m, n-1)
    end

    ##############power###########
    ##############qpower###########
    def qpwr(m, 1) do m end
    def qpwr(m,n) when rem(n, 2)!=0 do m * qpwr(m, n-1) end
    def qpwr(m, n) do
        x = qpwr(m, div(n,2))
        x * x
    end
    ##############qpower###########
end
###########to_int#############
defmodule Binary do
    
    # def to_integer(x) do to_integer(x, 0) end

    # def to_integer([], n) do n end

    # def to_integer([x | r], n) do
    #     {n, res} = to_integer(r, n)
    #     n= n + 1
    #     res = res+ (x * Recursion.pwr(2,n))
    #     {n, res} 
    # end

    def to_integer(x) do to_integer(Enum.reverse(x), 0, 0) end

    def to_integer([], pos, acc) do acc end

    def to_integer([x | r], pos, acc) do
        acc= acc + Recursion.pwr(2, pos) * x
        
        to_integer(r, pos+1, acc) 
    end

    # def rsum(l) do rsum(l, 0) end
    # def rsum([], acc) do
    #     acc
    # end
    # def rsum([h|t], acc) do
    #     acc = rsum(t,acc) + h
    # end
end
