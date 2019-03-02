class BeesWax
  attr_accessor :type # You can add these to be able to remove the setter and getter methods

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax" # Can change @type to just type because attr_accessor lets us access the instance variable
    # it is standard practice to refer to instance variables inside the class without @ if the getter method is available.
  end
end

wax = BeesWax.new("good type")

wax.describe_type