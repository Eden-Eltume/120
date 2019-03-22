class Person
  def secret=(new_secret)
    @secret = new_secret
  end

  def secret
    @secret
  end
end

person1 = Person.new
person1.secret = "Shh.. this is a secret!"
puts person1.secret