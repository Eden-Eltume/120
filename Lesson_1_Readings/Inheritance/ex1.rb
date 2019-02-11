class Vehicle
  STEERING_WHEEL = true

  def info
    "It is #{STEERING_WHEEL} that there is a steering wheel."
  end
end

class MyCar < Vehicle
  SEATS = 2

  def info_seats
    "There are #{SEATS} seats."
  end
end

class MyTruck < Vehicle
  WHEELS = 6

  def info_wheels
    "There are #{WHEELS} wheels."
  end
end

volvo = MyCar.new()
uncles_truck = MyTruck.new()

puts volvo.info
puts volvo.info_seats

puts uncles_truck.info_wheels
puts uncles_truck.info