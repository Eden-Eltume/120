class Vehicle
  attr_reader :year

  STEERING_WHEEL = true

  def initialize(year)
    @year = year
  end

  def info
    "It is #{STEERING_WHEEL} that there is a steering wheel."
  end

  def age
    "Your vehicle is #{years_old} years old."
  end

  private
  def years_old
    Time.now.year - self.year
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

my_car = MyCar.new(2001) # 2019 - 2001 is 18 years old 
puts my_car.age