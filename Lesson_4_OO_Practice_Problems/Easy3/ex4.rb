class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    downcased_class_name = self.class.to_s.downcase
    puts "I am a #{type} #{downcased_class_name}"
  end
end

tabby = Cat.new("tabby")

tabby.to_s