class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
p oracle.predict_the_future

=begin
Each time you call, a string is returned which will be of the form "You will <something>", where the something is one of the 3 phrases defined in the array returned by the choices method. 
The specific string will be chosen randomly.
=end