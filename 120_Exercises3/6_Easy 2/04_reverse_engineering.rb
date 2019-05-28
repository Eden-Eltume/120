class Transform
  def initialize(word)
    @word = word
  end

  def uppercase
    @word.upcase
  end

  def self.lowercase(word)
    word.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')