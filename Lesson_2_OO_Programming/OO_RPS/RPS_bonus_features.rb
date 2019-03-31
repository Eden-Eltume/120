# OOP of RPSLS
class Player
  attr_accessor :move, :name

  def initialize
    set_name()
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock (r), paper (p), scissors (s), lizard (l), or spock (k)."
      choice = gets.chomp.downcase

      choice_keys = Move::VALID_CHOICES.keys
      choice_values = Move::VALID_CHOICES.values
      break if choice_keys.include?(choice) || choice_values.include?(choice)
      puts "Sorry, invalid choice."
    end
    player_choice = Move::VALID_CHOICES.key(choice)
    self.move = Move.new(player_choice)
  end
end

class Computer < Player
  @@frequent_moves = []

  def set_name
    self.name = ['R2D2', 'Ultron'].sample
  end

  def choose
    if self.name == "R2D2"
      r2d2()
    elsif self.name == "Ultron"
      ultron()
    end
  end

  def find_humans_habit
    @@frequent_moves << MovesHistory.frequent_human_move()
  end

  def r2d2
    if @@frequent_moves.size < 2
      preferred_move = ["lizard", "spock"].sample
      self.move = Move.new(preferred_move)
    else
      humans_move = @@frequent_moves.flatten.pop
      winning_moves = Move::VALID_CHOICES.keys.select do |valid_choice|
        if WinningCombos.tell_who_won(humans_move, valid_choice) == "computer"
          valid_choice
        end
      end
      self.move = Move.new(winning_moves.sample)
    end
  end

  def ultron
    if @@frequent_moves.size < 2
      preferred_move = ["rock", "paper", "scissors"].sample
      self.move = Move.new(preferred_move)
    else
      humans_move = @@frequent_moves.flatten.pop
      winning_moves = Move::VALID_CHOICES.keys.select do |valid_choice|
        if WinningCombos.tell_who_won(humans_move, valid_choice) == "computer"
          valid_choice
        end
      end
      self.move = Move.new(winning_moves.sample)
    end
  end

class Move
  attr_accessor :computer, :human

  VALID_CHOICES = {
    'rock' => 'r',
    'paper' =>  'p',
    'scissors' => 's',
    'lizard' => 'l',
    'spock' =>  'k'
  }

  def initialize(value)
    @value = value
  end

  def to_s
    "#{@value}"
  end
end

module WinningCombos
  WINNING_SCENARIOS = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'lizard' => ['spock', 'paper'],
    'spock' => ['scissors', 'rock']
  }

  def self.win?(choice1, choice2)
    WINNING_SCENARIOS.values_at(choice1).flatten.include?(choice2)
  end

  def self.tell_who_won(player, computer)
    if win?(player, computer)
      "player"
    elsif win?(computer, player)
      "computer"
    else
      "tie"
    end
  end
end

module ScoreBoard
  NUMBER_OF_WINS = 5

  @@players_score = 0
  @@computers_score = 0
  @@ties = 0

  def self.increment_score(result)
    if result == "player"
      @@players_score += 1
    elsif result == "computer"
      @@computers_score += 1
    else
      @@ties += 1
    end
  end

  def self.game_over?
    @@players_score >= NUMBER_OF_WINS || @@computers_score >= NUMBER_OF_WINS
  end

  def self.display_score
    puts "SCORE:"
    puts "Player: #{@@players_score}"
    puts "Computer: #{@@computers_score}"
    puts "Ties: #{@@ties}"
  end

  def self.human_won?
    if @@players_score >= @@computers_score
      true
    else
      false
    end
  end
end

class MovesHistory
  @@humans_past = []
  @@computers_past = []

  def initialize(humans_move, computers_move)
    @@humans_past.push(humans_move)
    @@computers_past.push(computers_move)
  end

  def self.frequent_human_move
    @@humans_past.select { |el| @@humans_past.count(el) >= 2 }.pop
  end

  def self.humans_history(the_human)
    puts "#{the_human} has chosen the following moves: #{@@humans_past}"
  end

  def self.computers_history(the_computer)
    puts "#{the_computer} has chosen the following moves: #{@@computers_past}"
  end
end

class Game
  include WinningCombos
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
    puts "Your opponent is #{computer.name}"
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def winner
    WinningCombos.tell_who_won("#{human.move}", "#{computer.move}")
  end

  def display_moves
    puts "#{human.name}, chose: #{human.move}."
    puts "#{computer.name}, chose: #{computer.move}."
  end

  def clear_screen
    system('clear' || 'clr')
  end

  def display_who_won
    if ScoreBoard.human_won?
      puts "#{human.name} has won the game!"
    else
      puts "#{computer.name} has won the game!"
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

    answer == 'y' ? true : false
  end

  def play
    display_welcome_message()
    loop do
      human.choose
      computer.choose
      MovesHistory.new("#{human.move}", "#{computer.move}")
      computer.find_humans_habit()
      result = winner()
      ScoreBoard.increment_score(result)
      display_moves
      clear_screen
      ScoreBoard.display_score
      break if ScoreBoard.game_over? || !play_again?
    end
    puts "-" * 50
    MovesHistory.humans_history(human.name)
    MovesHistory.computers_history(computer.name)
    puts "-" * 50
    display_who_won()
    display_goodbye_message()
  end
end

Game.new.play
