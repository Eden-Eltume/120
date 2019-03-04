class Cat
  def initialize(name)
    @name = name
  end

  def name  #Alternatively, you could use the attr_reader :name
    @name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new("Sophie")
kitty.greet

