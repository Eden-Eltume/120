# We can make the Bingo class inherit from Game by using the < keyword.
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

bingo_game = Bingo.new
puts bingo_game.play