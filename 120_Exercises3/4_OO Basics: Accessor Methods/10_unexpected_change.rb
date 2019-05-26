class Person
  def name
    "#{@fname} #{@lname}"
  end

  def name=(new_name)
    @fname, @lname = new_name.split(' ')
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name