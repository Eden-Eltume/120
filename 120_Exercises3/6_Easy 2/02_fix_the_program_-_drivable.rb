module Drivable
  def drive
    puts "Driving.."
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive