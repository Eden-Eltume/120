class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! I'm a cat, named #{name}."
  end

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end
end

kitty = Cat.new("Kitty")
kitty.greet

kitty.name = "Luna"
kitty.greet