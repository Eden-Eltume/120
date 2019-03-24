class GuessingGame
  attr_accessor :the_number, :low, :high

  @@guess = nil
  @@guesses_left = 1
  def initialize(low, high)
    @low = low
    @high = high
    @the_number = rand(low..high)
    @@guesses_left += Math.log2(high - low).to_i
  end

  def welcome
    puts "Welcome"
    puts "You have #{@@guesses_left} guesses to guess the number I'm thinking of."
  end

  def prompt
    puts "Enter a number between #{@low} and #{@high}: "
    @@guess = gets.chomp.to_i
  end

  def display_guesses_left
    puts "You have #{@@guesses_left} guesses remaining."
  end

  def validate_guess
    if @@guess.between?(@low, @high)
      @@guesses_left -= 1
    else
      puts "Invalid guess. Enter a number between #{@low} and #{@high}: "
      @@guess = gets.chomp.to_i
    end
  end

  def high_or_low
    puts @@guess > @the_number ? "Your guess is too high." : "Your guess is too low."
  end

  def play
    welcome()
    loop do
      prompt()
      validate_guess()
      display_guesses_left()
      high_or_low()
      if @@guess == @the_number
        puts "Congratulations, you guessed the number #{@the_number}!"
        break
      elsif @@guesses_left <= 0
        puts "You lost! The number was #{@the_number}"
        break
      end
    end
  end
end


game = GuessingGame.new(501, 1500)
game.play

=begin
You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.
=end