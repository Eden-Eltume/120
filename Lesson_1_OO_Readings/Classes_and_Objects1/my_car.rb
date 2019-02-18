class MyCar
  attr_accessor :speed, :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(boost)
    self.speed += boost
    "The car is now going at #{self.speed} mph."
  end

  def current_speed
    "You are traveling at #{self.speed} mph"
  end

  def brake(number)
    self.speed -= number
    "Slowing down car at #{self.speed} mph.."
  end

  def stop
    self.speed = 0
    "The car is now shutdown!"
  end

  def spray_paint(new_color)
    self.color = new_color
    "The car's color has been change to #{self.color}"
  end
end

volvo = MyCar.new("2001", "Gray", "S60")

puts volvo.current_speed
puts volvo.speed_up(10)
puts volvo.brake(5)
puts volvo.stop

puts volvo.color
puts volvo.year # Should be viewable
#puts volvo.year = "2003" # Should be undefined

puts volvo.spray_paint("yellow")