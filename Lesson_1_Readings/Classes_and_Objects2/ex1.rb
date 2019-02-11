class MyCar
    @@mileage = 0

  def self.calculate_mileage(increase)
    @@mileage += increase
    "You are going from 0 to #{increase} mph!"
  end
end

puts MyCar.calculate_mileage(10)