class Vehicle
  STEERING_WHEEL = true
  @@objects_created = 0

  def initialize
    @@objects_created += 1
  end

  def self.print_objects_created
    "#{@@objects_created} objects were created."
  end

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

puts Vehicle.print_objects_created