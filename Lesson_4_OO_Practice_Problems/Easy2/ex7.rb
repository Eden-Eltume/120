=begin
The @@cats_count variables tallies the number of objects created by the initialize method.
In order to test it, you would need to instantiate one or more objects and output the class method cats_count.
But in order to see cats_count incrementally increased you would have to output the cats_count
=end

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
    puts @@cats_count
  end

  def self.cats_count
    @@cats_count
  end
end

kali = Cat.new("Kali")
kitty = Cat.new("Kitty")

total_cats = Cat.cats_count
puts "The total number of cats created is #{total_cats}"