=begin
We can turn hi into a class method by prepending self. to the method name.

Note that we cannot simply call greet in the self.hi method definition because the Greeting class itself only defines greet on its instances, rather than on the Greeting class itself.
=end