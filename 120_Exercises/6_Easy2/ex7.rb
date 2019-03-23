class Shelter

  @@adoptions = {}

  def adopt(owner, pet)
    if @@adoptions.has_key?(owner)
      @@adoptions[owner] << pet
      owner.add_pet
    else
      @@adoptions[owner] = [pet]
      owner.add_pet
    end
  end

  def print_adoptions
    @@adoptions.each_key do |owner|
      puts "#{owner} has adopted the following pets:"
      @@adoptions[owner].each do |pets|
        puts "• a #{pets.type} named #{pets.name}"
      end
    end
  end
end

class Owner
  attr_reader :name, :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end

  def to_s
    @name
  end

  def add_pet
    @number_of_pets += 1
  end

  def number_of_pets
    @number_of_pets
  end
end

class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."