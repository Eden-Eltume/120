class Person
  attr_accessor :name
  attr_writer :last_name

  def initialize(name)
    @name = name
  end

  def first_name
    @name
  end
  
  def last_name
    @last_name
  end

  def name
    "#{first_name} #{last_name}"
  end
end

bob = Person.new('Robert')
puts bob.name                  # => 'Robert'

puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''

bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'