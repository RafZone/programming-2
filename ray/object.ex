defprotocol Object do
    def intersect(object, ray)
end

defmodule Sphere do
    defstruct pos: {0, 0, 0}, radius: 2
end

# i1 and i2 are intersection points on sphere with ray
#first calculat we need to calculate a
#length a = dot product of k and ^i
# c (center of circle) and o are known => 
#we can calculate length of k, the radius of the circle is known -> use Pythagoras to calculate h
