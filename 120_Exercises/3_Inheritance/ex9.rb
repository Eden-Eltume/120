module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

=begin
bird1.color lookup path is as follow:
[Bird, Flyable, Animal]
The class is searched before the module. 
But, the module is searched before the superclass.
=end