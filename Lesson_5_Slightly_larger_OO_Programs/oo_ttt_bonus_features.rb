class Board
  attr_accessor :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagonals

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def at_risk_square(marker)
    final_square = nil
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if win_is_imminent?(squares, marker)
        line.each do |square|
          if @squares[square].unmarked?
            final_square = square
          end
        end
      end
    end
    final_square
  end

  def unmarked_middle?
    @squares[5].unmarked?
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def win_is_imminent?(squares, player_marker)
    squares.select { |square| square.marker == player_marker }.count == 2 &&
      squares.select(&:unmarked?).size == 1
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class Scoreboard
  WINNING_SCORE = 3

  attr_reader :human_score, :computer_score, :ties

  def initialize
    @human_score = 0
    @computer_score = 0
    @ties = 0
    @the_winner = ''
  end

  def display_result
    puts ""
    puts "-" * 10 + "Scoreboard" + "-" * 10
    puts "You:#{human_score}  " + "Computer:#{computer_score} " \
         " Ties:#{ties}  "
    puts "-" * 15 + "-" * 15
    puts ""
  end

  def update(winning_marker)
    if winning_marker == TTTGame::HUMAN_MARKER
      @human_score += 1
    elsif winning_marker == TTTGame::COMPUTER_MARKER
      @computer_score += 1
    else
      @ties += 1
    end
  end

  def winner?
    if @human_score > 1 && @human_score == WINNING_SCORE
      @the_winner = "You"
      true
    elsif @computer_score > 1 && @computer_score == WINNING_SCORE
      @the_winner = "Computer"
      true
    else
      false
    end
  end

  def display_winner
    puts ""
    puts "GAME OVER! The winner is #{@the_winner}!"
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer, :scoreboard

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @scoreboard = Scoreboard.new
  end

  def prompt_first_to_move
    answer = nil
    loop do
      puts "Would you like to go first (y) or the computer (n)?"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, you must answer y or n"
    end
    @marker_first_answer = answer
  end

  def choose_first_to_move
    @current_marker = if @marker_first_answer == 'y'
                        HUMAN_MARKER
                      else
                        COMPUTER_MARKER
                      end
  end

  def start_of_game_settings
    clear_screen
    display_welcome_message
    prompt_first_to_move
    choose_first_to_move
  end

  def round_ended?
    board.someone_won? || board.full?
  end

  def play
    start_of_game_settings

    loop do
      loop do
        clear_screen_and_display_board if humans_turn?
        current_player_moves
        break if round_ended?
      end

      display_board
      update_score
      display_result
      break if game_over? || !play_again?
      reset_game
      display_play_again_message
    end

    end_of_game
  end

  def update_score
    scoreboard.update(board.winning_marker)
  end

  def game_over?
    scoreboard.winner?
  end

  def end_of_game
    display_winner_and_goodbye if game_over?
  end

  private

  def current_player_moves
    if humans_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def humans_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_welcome_message
    puts "Welcome to Tic-Tac-Toe!" \
         "There's #{Scoreboard::WINNING_SCORE} rounds." \
         "The last person to win goes first."
    puts ""
  end

  def display_score
    scoreboard.display_result
  end

  def display_goodbye_message
    puts "Thanks for play Tic Tac Toe! Goodbye!"
  end

  def display_winner_and_goodbye
    scoreboard.display_winner
    display_goodbye_message
  end

  def joinor(arr, delimiter=', ', word='or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr[-1] = "#{word} #{arr.last}"
      arr.join(delimiter)
    end
  end

  def valid_int?(input_string)
    input_string.to_i.to_s == input_string
  end

  def human_moves
    keys_left = joinor(board.unmarked_keys)
    puts "Choose a square: (#{keys_left}) "
    square = nil
    loop do
      square = gets.chomp
      break if valid_int?(square) && board.unmarked_keys.include?(square.to_i)
      puts "Sorry, that's not a valid choice."
    end

    board[square.to_i] = human.marker
  end

  def computer_moves
    if board.at_risk_square(computer.marker)
      attack_at_risk_square
    elsif board.at_risk_square(human.marker)
      defend_at_risk_square
    elsif board.unmarked_middle?
      choose_middle_square
    else
      choose_random_square
    end
  end

  def attack_at_risk_square
    board[board.at_risk_square(computer.marker)] = computer.marker
  end

  def defend_at_risk_square
    board[board.at_risk_square(human.marker)] = computer.marker
  end

  def choose_middle_square
    board[5] = computer.marker
  end

  def choose_random_square
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_board
    puts "You're #{human.marker} and the computer is #{computer.marker}."
    puts ""
    board.draw()
    puts ""
  end

  def clear_screen
    system('clear' || 'clr')
  end

  def clear_screen_and_display_board
    display_score
    clear_screen
    display_board
  end

  def display_result
    display_score
    case board.winning_marker
    when HUMAN_MARKER
      puts "You won this round!"
    when COMPUTER_MARKER
      puts "The computer won this round!"
    else
      puts "It's a tie!"
    end
  end

  def set_winning_marker
    case board.winning_marker
    when HUMAN_MARKER
      @current_marker = HUMAN_MARKER
    when COMPUTER_MARKER
      @current_marker = COMPUTER_MARKER
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reverse_current_marker
    @current_marker = if @current_marker == COMPUTER_MARKER
                        HUMAN_MARKER
                      else
                        COMPUTER_MARKER
                      end
  end

  def reset_game
    board.reset
    if !board.winning_marker.nil?
      @current_marker = board.winning_marker
    else
      reverse_current_marker
    end
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
