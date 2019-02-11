class MyCar
  attr_reader :color, :year, :model

  def initialize(color, year, model)
    @color = color
    @year = year
    @model = model
  end

  def to_s
    "My car is a #{color}, #{year}, #{@model}!"
  end
end

my_car = MyCar.new("2010", "Ford Focus", "silver")
puts my_car