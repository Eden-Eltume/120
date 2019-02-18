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
  attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name()
  end

  def set_name
    if human?
      n = ""
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must enter a value."
      end
      self.name = n
    else
      self.name = ['R2D2', 'Ultron'].sample
    end
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
    puts "#{human.name}, chose: #{human.move}."
    puts "#{computer.name}, chose: #{computer.move}."

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts "#{human.name} won!" if computer.move == 'scissors'
      puts "#{computer.name} won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} won!" if computer.move == 'rock'
    end 
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    return true if answer == 'y'
    return false
  end

  def play
    # possible methods will need
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
