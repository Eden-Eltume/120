=begin
Nothing incorrect syntactically.
However, you are altering the public interfaces of the class.
In other words, you are now allowing clients of the class to change the quantity directly (calling the accessor with the instance.quantity = <new value> notation) rather than by going through the update_quantity method.
It means that the protections built into the update_quantity method can be circumvented and potentially pose problems down the line.
=end