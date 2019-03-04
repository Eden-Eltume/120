# Namespacing is where similar classes are grouped within a module. 
module Transportation
  class Vehicle; end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end
end