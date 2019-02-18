class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Pet
  def pur
    "Purrrr!"
  end

  def scratch
    "Scratch! Scratch!"
  end
end

kitty = Cat.new
puts kitty.jump 
puts kitty.scratch