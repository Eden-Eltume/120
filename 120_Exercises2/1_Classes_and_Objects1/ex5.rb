class Cat
  def initialize(name)
    @name = name
  end

  def say_name
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.say_name