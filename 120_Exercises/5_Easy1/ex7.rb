class Car
  attr_writer :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = @mileage + miles
    @mileage = total
  end

  def print_mileage
    puts @mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
