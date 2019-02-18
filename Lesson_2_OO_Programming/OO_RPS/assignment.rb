=begin
Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.
=end

=begin
Nouns: player, move, rule
Verbs: choose, compare
=end

class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose
  end
end

class Move
  def initialize
    # we'll need to keep track of the choice
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# don't know where this goes yet
def compare(move1, move2)

end

# we need a something like this to easily play the game
class RPSGame
  def initialize
  end

  def play
    # possible methods will need
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    displa_goodbye_message
  end
end

