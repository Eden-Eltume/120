=begin
Currently the method is defined as self.light_information, which seems reasonable. 
But when using or invoking the method, we would call it like this: Light.light_information. Having the word "light" appear twice is redundant. Therefore, we can rename the method to just self.information, and we can invoke it like this Light.information. 
This reads much better -- remember, you're writing code to be readable by others as well as your future self.
=end