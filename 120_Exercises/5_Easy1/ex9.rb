class Pet
  attr_reader :name, :age

  def initialize(name, age, color)
    @name = name
    @age = age
    @color = color
  end
end

class Cat < Pet
  def to_s
    "My cat #{@name} is #{@age} and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white.')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

