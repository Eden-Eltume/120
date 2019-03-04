class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

=begin
The method lookup path for cat1.color is as follow:
[Cat, Animal, Object, Kernel, BasicObject]
=end