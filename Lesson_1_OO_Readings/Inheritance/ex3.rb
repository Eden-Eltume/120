class Vehicle
  STEERING_WHEEL = true

  def info
    "It is #{STEERING_WHEEL} that there is a steering wheel."
  end
end

module Tailgate
  def whats_its_called
    "Yes aka the back of a pickup truck is called a tailage"
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

  include Tailgate

  def info_wheels
    "There are #{WHEELS} wheels."
  end
end

the_truck = MyTruck.new()
puts the_truck.whats_its_called