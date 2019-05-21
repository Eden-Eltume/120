class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! I'm a cat, named #{@name}."
  end
end

kitty = Cat.new("Kitty")
kitty.greet