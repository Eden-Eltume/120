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
  attr_accessor :move

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
  end

  def choose
    if human?
      choice = nil
      loop do 
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if ["rock", "paper", "scissors"].include?(choice)
        puts "Sorry, invalid choice."
      end
      self.move = choice
    else
      self.move = ["rock", "paper", "scissors"].sample
    end
  end

  def human?
    @player_type == :human
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
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_winner
    puts "You chose: #{human.move}."
    puts "The computer chose: #{computer.move}."

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts "You won!" if computer.move == 'scissors'
      puts "Computer won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts "You won!" if computer.move == 'rock'
      puts "Computer won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts "You won!" if computer.move == 'paper'
      puts "Computer won!" if computer.move == 'rock'
    end 
  end

  def play
    # possible methods will need
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play
