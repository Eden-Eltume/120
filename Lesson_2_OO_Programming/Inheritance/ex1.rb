class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming'
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

billy = Bulldog.new
puts billy.speak
puts billy.swim