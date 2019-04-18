TERMINAL_SIZE = 80
HALF_TERMINAL = TERMINAL_SIZE / 2

module Currency
  def display_currency(dollars)
    if dollars.to_s.length > 3
      dollars.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse + ".00"
    else
      format('%.2d', dollars)
    end
  end
end

class Participant
  attr_accessor :hand

  def busted?
    @hand.total > 21
  end

  def >(other_participant)
    total > other_participant.total
  end

  def total
    @hand.total
  end

  def blackjack?
    total == 21 && @hand.cards.size == 2
  end
end

class Player < Participant
  include Currency
  attr_accessor :bet, :money

  STARTING_CASH = 1_000

  def initialize
    @money = STARTING_CASH
    @bet = 0
  end

  def hit?
    answer = ''
    puts "(h)it or (s)tay?"
    loop do
      answer = gets.chomp.downcase
      break if answer == 'h' || answer == 's'
      puts "That's not a valid choice."
      puts "Please enter 'h' or 's'"
    end
    answer == 'h'
  end

  def bets
    answer = ''
    puts "How much money are you betting?"

    loop do
      answer = gets.downcase.to_i
      break if valid_bet?(answer)
    end

    self.bet = answer
    self.money -= answer
  end

  def pay_bet
    factor = blackjack? ? 2.5 : 2
    @money += @bet * factor
    @bet = 0
  end

  def take_bet
    @bet = 0
  end

  def push_result
    @money += @bet
    @bet = 0
  end

  def broke?
    @money <= 0
  end

  def display_money
    puts "Balance: $#{display_currency(money)}".rjust(HALF_TERMINAL)
    puts " Bet: $#{display_currency(bet)}".rjust(HALF_TERMINAL)
    puts "-"*TERMINAL_SIZE
  end

  private

  def valid_bet?(answer)
    max_bet_not_exceeded = true
    min_bet_met = true

    if money - answer < 0
      puts "You cannot bet more money than you have!"
      max_bet_not_exceeded = false
    end

    if answer < Game::MINIMUM_BET
      puts "You must bet at least $#{Game::MINIMUM_BET}."
      min_bet_met = false
    end

    if money < Game::MINIMUM_BET && max_bet_not_exceeded
      min_bet_met = true
    end

    max_bet_not_exceeded && min_bet_met
  end
end

class Dealer < Participant
  def hit?
    @hand.total < 17
  end

  def total(show = true)
    show ? super() : ''
  end

  def total_hidden
    total(false)
  end
end

class Hand
  attr_reader :cards

  def initialize
    @cards = []
    @card_total = 0
  end

  def total
    result = 0
    ace = false
    @cards.each do |card|
      result += card.value
      ace = true if card.name == 'A'
    end
    return result + 10 if ace && result <= 11
    result
  end

  def [](dealt_card)
    cards << dealt_card
  end

  def to_s
    result = ""
    @cards.each do |card|
      result += "#{card} "
    end
    result
  end

  def display_hole_card_hidden
    dealer_hand = to_s
    space_idx = dealer_hand.index(' ')
    dealer_hand[space_idx, 4] = ' XX '
    dealer_hand
  end
end

class Deck
  SUITS = ['♣', '♥', '♠', '♦']
  CARD_NAMES = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  CARD_VALS = (1..10).to_a + [10, 10, 10]

  def initialize
    @shuffled_cards = make_deck.shuffle
  end

  def make_deck
    deck = []
    SUITS.each do |suit|
      CARD_NAMES.each_with_index do |card_name, index|
        card = Card.new(card_name, suit, CARD_VALS[index])
        deck << card
      end
    end
    deck
  end

  def deal_one_card
    @shuffled_cards.shift
  end
end

class Card
  attr_reader :name, :suit, :value

  def initialize(n, s, v)
    @name = n
    @suit = s
    @value = v
  end

  def to_s
    "#{name}#{suit}"
  end
end

class Game
  include Currency

  MINIMUM_BET = 5
  attr_accessor :deck, :player, :dealer

  private

  def initialize
    @player = Player.new
    @dealer = Dealer.new
  end

  def new_deck
    @deck = Deck.new
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to 21!"
    puts "You start with $#{Player::STARTING_CASH}," \
         " the minimum bet is $#{MINIMUM_BET}"
    puts "Automatic blackjack means you win 1.5x the money!"
  end

  def hit(participant)
    participant.hand[deck.deal_one_card]
  end

  def deal_initial_cards
    player.hand = Hand.new
    dealer.hand = Hand.new

    2.times do
      player.hand[deck.deal_one_card]
      dealer.hand[deck.deal_one_card]
    end
  end

  def display_table(dealer_hidden = false)
    clear_screen
    @player.display_money

    display_arr = [ [@dealer.hand, @player.hand],
                     [@dealer.total, @player.total] ]

    puts "Dealer".ljust(HALF_TERMINAL) + "You".ljust(HALF_TERMINAL)
    display_arr.each do |category|
      puts "Hand: #{category.shift}".ljust(HALF_TERMINAL) + "Total: #{category.pop}".ljust(HALF_TERMINAL) 
    end
    puts "-"*TERMINAL_SIZE
  end

  def display_table_dealer_hidden
    display_table(true)
  end

  def blackjack?
    player.blackjack? || dealer.blackjack?
  end

  def player_turn
    loop do
      hit_decision = player.hit?
      hit(player) if hit_decision
      break if player.total == 21
      display_table_dealer_hidden
      break if player.busted? || !hit_decision
    end
  end

  def dealer_turn
    display_table
    while dealer.hit?
      puts "Dealer hits..."
      sleep(1.2)
      hit(dealer)
      display_table
      break if dealer.busted?
    end
  end

  def winner
    if player.busted?
      'dealer'
    elsif dealer.busted?
      'player'
    elsif player > dealer
      'player'
    elsif dealer > player
      'dealer'
    end
  end

  def display_blackjack
    4.times do
      puts "Blackjack!"
      sleep(1)
    end
  end

  def reconcile_bet
    case winner
    when 'dealer' then player.take_bet
    when 'player' then player.pay_bet
    else player.push_result
    end
  end

  def display_result
    case winner
    when 'dealer' then puts "Dealer wins!"
    when 'player' then puts "You win!"
    else puts "It's a tie! You get your betting money back."
    end
  end

  def busted_message
    if player.busted?
      puts "You BUSTED!"
    elsif dealer.busted?
      puts "Dealer BUSTED!"
    end
  end

  def play_again?
    answer = ''
    loop do
      puts "Play another hand? (y/n)"
      answer = gets.chomp.downcase
      break if answer == 'y' || answer == 'n'
      puts "That's not a valid choice."
      puts "Please enter 'y' or 'n'"
    end
    answer == 'y'
  end

  def display_goodbye_message
    puts ""
    puts "Thanks for playing 21."
    amount = player.money - Player::STARTING_CASH
    result = if amount < 0
               'lost'
             else
               'made a net profit of'
             end
    puts "You #{result} $#{display_currency(amount.abs)}."
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def begin_hand
    new_deck
    @player.bets
    deal_initial_cards
    display_table_dealer_hidden
  end

  def blackjack_or_continue
    if blackjack?
      display_table
      display_blackjack
    else
      player_turn
      dealer_turn unless @player.busted?
    end
  end

  def end_hand
    reconcile_bet
    display_table
    busted_message
    display_result
  end

  public

  def start
    display_welcome_message

    loop do
      begin_hand
      blackjack_or_continue
      end_hand
      if @player.broke?
        puts "You ran out of money. Good luck next time!"
        break
      end
      break unless play_again?
    end

    display_goodbye_message
  end
end

Game.new.start