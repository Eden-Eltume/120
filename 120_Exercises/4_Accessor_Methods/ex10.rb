class Person
  def name
    @first_name + " " + @last_name
  end

  def name=(name)
    full_name_array = splice_name(name)
    @first_name = full_name_array.first
    @last_name = full_name_array.last
  end

  private
  def splice_name(full_name_string)
    full_name_string.split(" ")
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
