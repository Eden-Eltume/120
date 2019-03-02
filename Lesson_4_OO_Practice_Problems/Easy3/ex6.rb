# We could simply remove the self keyword because attr_accessor gives us acess to the age instance variable.
# Thus making the keyword self redudant.
# This means in this case self and @ are the same thing and can be used interchangeably.

class Cat
  attr_reader :age

  def initialize(type)
    @type = type
    @age  = 3
  end

  def make_one_year_older
    @age += 10 #variable shadowing so, closest variable will be read. Trying to increment an uninitialized variable will result in error. 
    # So be explicit by adding @.
    "The cat is #{age} years old."
  end
end

kitty = Cat.new("fat")
puts kitty.make_one_year_older