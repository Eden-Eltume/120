=begin
  The method lookup path is the order in which a method is called.
  It goes from the class the method is in then to the modules from bottom to top and then up to the next last.
  The final lookup path are Object, Kernel, BasicObject
=end

# It is important begins it determines how our code will be executed.
# To look up a method lookup path, you can call the ancestors method on an object.