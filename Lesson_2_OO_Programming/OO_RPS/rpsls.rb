VALID_CHOICES = {
  'rock'      =>  'r',
  'paper'     =>  'p',
  'scissors'  =>  's',
  'lizard'    =>  'l',
  'spock'     =>  'k'
}

SCORE_TO_WIN = 5

WINNING_SCENARIOS = {
  'rock'     => ['scissors', 'lizard'],
  'paper'    => ['rock', 'spock'],
  'scissors' => ['paper', 'lizard'],
  'lizard'   => ['spock', 'paper'],
  'spock'    => ['scissors', 'rock']
}

class Player
  attr_accessor :move, :history

  def initialize
    @history = []
  end

  def to_s
    "#{self.class} history: #{history}"
  end
end

class Human < Player
  def choose
    letter_choice = ''
    puts("Choose:")
    loop do
      break if VALID_CHOICES.values.include?(letter_choice)
      VALID_CHOICES.each do |valid_choice, letter|
        puts("#{letter} for #{valid_choice}")
      end
      letter_choice = gets.chomp.downcase
      puts("Invalid choice. Choose again:")
    end
    @move = VALID_CHOICES.key(letter_choice)
    @history << @move
  end

  def chose_valid_move?
    VALID_CHOICES.keys.include?(move)
  end

  def win_against?(computer)
    WINNING_SCENARIOS.values_at(move).flatten.include?(computer.move)
  end

  protected

  attr_accessor :computer
end

class Computer < Player
  attr_reader :name

  def initialize
    super
    @name = ['R2D2', 'Ultron'].sample
  end

  def choose(human)
    name == 'R2D2' ? r2d2(human) : ultron(human)
  end

  def r2d2(human)
    humans_fave_move = find_fave_move(human)
    if !humans_fave_move.nil?
      beat_human(humans_fave_move)
    else
      @move = VALID_CHOICES.keys[3..-1].sample
      @history << move
    end
  end

  def ultron(human)
    humans_fave_move = find_fave_move(human)
    if !humans_fave_move.nil?
      beat_human(humans_fave_move)
    else
      @move = VALID_CHOICES.keys[0..2].sample
      @history << move
    end
  end

  def beat_human(fave)
    counters = WINNING_SCENARIOS.select { |_, moves| moves.include?(fave) }.keys
    @move = counters.sample
    @history << move
  end

  def find_fave_move(human)
    human.history.select { |el| human.history.count(el) >= 2 }.pop
  end

  def win_against?(human)
    WINNING_SCENARIOS.values_at(move).flatten.include?(human.move)
  end

  protected

  attr_accessor :human
end

class ScoreBoard
  attr_accessor :human_score, :computer_score, :ties

  def initialize
    @human_score = 0
    @computer_score = 0
    @ties = 0
  end

  def increment_human_score
    self.human_score += 1
  end

  def increment_computer_score
    self.computer_score += 1
  end

  def increase_tie_count
    self.ties += 1
  end

  def winner_yet?
    self.human_score == SCORE_TO_WIN || self.computer_score == SCORE_TO_WIN
  end

  def display_winner
    if self.human_score > self.computer_score
      puts "You beat the computer! Good job."
    else
      puts "The computer won."
    end
  end

  def to_s
    "You: #{human_score}, Computer: #{computer_score} and Ties: #{ties}"
  end
end

class Game
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
    @scoreboard = ScoreBoard.new
  end

  def welcome_screen
    message = "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts message
    puts "You are playing against AI: #{computer.name}."
    puts "-" * message.length
  end

  def display_moves
    puts human, computer
  end

  def update_scoreboard
    if human.win_against?(computer)
      @scoreboard.increment_human_score
    elsif computer.win_against?(human)
      @scoreboard.increment_computer_score
    else
      @scoreboard.increase_tie_count
    end
  end

  def clear_screen
    system('clear' || 'clr')
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n."
    end

    answer == 'y' ? true : false
  end

  def game_over?
    return true if @scoreboard.winner_yet?
  end

  def display_goodbye_message
    @scoreboard.display_winner
    puts "Thanks for playing. Goodbye!"
  end

  def play
    welcome_screen
    loop do
      human.choose
      computer.choose(human)
      update_scoreboard
      clear_screen
      display_moves
      puts @scoreboard
      break if game_over? || !play_again?
    end
    display_goodbye_message
  end
end

Game.new.play
