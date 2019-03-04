class Person
  attr_reader :name

  def name=(new_name)
    @name = new_name.capitalize
  end
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name