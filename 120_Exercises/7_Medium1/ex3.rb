class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
  end
end

grad_student = Graduate.new("Mommy", 2021, true)
undergrad_student = Undergraduate.new("daughter", 2023)