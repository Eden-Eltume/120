class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "I am #{@name} the cat!"
  end
end

kitty = Cat.new("Sophie")
kitty.greet