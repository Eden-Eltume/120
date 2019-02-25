=begin
You can create a vehicle class and include the Speed module then have car & truck inherit from Vehicle.
=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Vehicle
  include Speed
end

class Car < Vehicle
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck < Vehicle
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

tesla = Car.new
semi = Truck.new

tesla.go_fast
semi.go_fast
