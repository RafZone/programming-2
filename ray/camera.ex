defmodule Camera do
    defstruct pos: nil, corner: nil, right: nil, down: nil, size: nil

def normal(size) do
    {width, height} = size
    d = width * 1.2
    h = width / 2
    v = height / 2
    corner = 0
    height
    d
    %Camera{pos: {0, 0, 0}, corner: corner, ..., ..., size: size)
end
end