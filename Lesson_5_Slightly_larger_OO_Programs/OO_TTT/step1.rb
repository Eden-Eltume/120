class Board
  def initialize
  end
end

class Square
  def initialize
  end
end

class Player
  def initialize
  end

  def mark
  end
end

class TTTGame
  def display_welcome_message
    puts "Welcome to Tic-Tac-Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for play Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts ""
    puts "     |     |     "
    puts "     |     |     "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "     |     |     "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "     |     |     "
    puts "     |     |     "
    puts ""
  end

  def play
    display_welcome_message
    loop do
      display_board
      break
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    #display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play