require 'pry'

CARD_RANKS = [
  'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine',
  'Ten', 'Jack', 'Queen', 'King', 'Ace'
].freeze
CARD_SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades'].freeze
CARD_VALUES = {
  Two: 2, Three: 3, Four: 4, Five: 5, Six: 6, Seven: 7, Eight: 8,
  Nine: 9, Ten: 10, Jack: 10, Queen: 10, King: 10, Ace: 11
}.freeze

class Game
  def initialize
    @player, @dealer, @deck = initialize_game
  end

  def display(final = false)
    clear
    display_score(@player.score, @dealer.score)
    display_cards(@player.cards, @dealer.cards, final)
    display_total(@player.cards) if final == false
    display_totals(@player.cards, @dealer.cards) if final == true
  end

  def result
    player = calculate_total(@player.cards)
    dealer = calculate_total(@dealer.cards)
    clear
    update_score(player, dealer)
    display(true)
    puts ''
    if player > BUST_AMOUNT then puts 'You busted!'
    elsif dealer > BUST_AMOUNT then puts 'Dealer busted!'
    else puts player > dealer ? 'You won the round!' : 'Dealer won the round!'
    end
  end

  def update_score(player, dealer)
    if player > BUST_AMOUNT then @dealer.score += 1
    elsif dealer > BUST_AMOUNT then @player.score += 1
    else player > dealer ? @player.score += 1 : @dealer.score += 1
    end
  end

  def restart(player, dealer)
    puts 'Press enter to play next round.'
    gets
    @deck = Deck.new
    player.cards = []
    dealer.cards = []
    2.times do
      player.get_card(@deck)
      dealer.get_card(@deck)
    end
  end

  def end?
    [@player.score, @dealer.score].include?(PLAY_UNTIL)
  end

  def display_winner
    puts 'You won the game!' if @player.score == PLAY_UNTIL
    puts 'Dealer won the game!' if @dealer.score == PLAY_UNTIL
  end

  attr_accessor :player, :dealer, :deck
end

class Deck
  def initialize
    @cards = []
    CARD_RANKS.each do |value|
      CARD_SUITS.each { |suit| @cards << [value, suit] }
    end
  end

  attr_accessor :cards
end

class Player
  def initialize
    @cards = []
    @score = 0
  end

  def get_card(deck)
    @cards << deck.cards.delete_at(rand(deck.cards.length))
  end

  attr_accessor :cards, :score
end

class User < Player
  def hit_or_stay
    answer = ''
    loop do
      puts ''
      print 'Hit or stay: '
      answer = gets.chomp.downcase
      break if %w(hit h stay s).include?(answer)
      clear
      puts "Please choose only one of the following: 'hit', 'h', 'stay', or 's'"
    end
    %w(hit h).include?(answer)
  end

  def play_again?
    answer = ''
    loop do
      puts ''
      print 'Do you want to play again: '
      answer = gets.chomp.downcase
      break if %w(yes y n no).include?(answer)
      clear
      puts "Please choose only 'yes', 'no', 'y', or 'n'."
    end
    %w(yes y).include?(answer)
  end
end

class Computer < Player
  def dealer_decision(game)
    puts 'Dealer is thinking...'
    sleep 1
    return true if calculate_total(game.dealer.cards) > DEALER_CAP - 1
    game.dealer.get_card(game.deck)
    puts 'Dealer hits'
    sleep 1
    return true if calculate_total(game.dealer.cards) > DEALER_CAP - 1
  end
end

def clear
  system('clear') || system('cls')
end

def initialize_game
  deck = Deck.new
  initialize_players(deck)
end

def initialize_players(deck)
  player = User.new
  dealer = Computer.new
  2.times do
    player.get_card(deck)
    dealer.get_card(deck)
  end
  [player, dealer, deck]
end

def display_score(player_score, dealer_score)
  puts "Player score: #{player_score}     |  Dealer score: #{dealer_score}"
  puts '                    |'
end

def display_totals(player, dealer)
  puts ''
  puts "Your total: #{calculate_total(player)}"
  puts "Dealer total: #{calculate_total(dealer)}"
end

def display_cards(player_cards, dealer_cards, final)
  top_display
  max_cards = [player_cards.length, dealer_cards.length].max
  bottom_display(player_cards, dealer_cards, max_cards, final)
end

def top_display
  puts "Your cards:         |  Dealer cards:"
  puts "--------------------+------------------------"
end

def bottom_display(player_cards, dealer_cards, max_cards, final)
  max_cards.times do |i|
    a = i > player_cards.length - 1
    b = i > dealer_cards.length - 1
    player = a ? '' : "#{player_cards[i][0]} of #{player_cards[i][1]}"
    dealer = b ? '' : "#{dealer_cards[i][0]} of #{dealer_cards[i][1]}"
    disply_columns(player, dealer, i, final)
  end
end

def disply_columns(player, dealer, i, final)
  print player
  print ' ' * (20 - player.length)
  print '|  '
  if i == 0 && final == false
    print '[hidden]'
  else
    print dealer
  end
  puts ''
end

def display_total(cards)
  puts ''
  puts "Player total: #{calculate_total(cards)}"
end

def calculate_total(cards)
  total = 0
  cards.each do |card|
    total += CARD_VALUES[card[0].to_sym]
  end
  total = adjust_total(total, cards) if total > BUST_AMOUNT
  total
end

def adjust_total(total, cards)
  cards.each do |card|
    total -= 10 if card[0] == 'Ace'
    break if total <= BUST_AMOUNT
  end
  total
end

def score_amount
  answer = nil
  clear
  loop do
    print 'What score would you like to play up to: '
    answer = gets.chomp
    break if answer.to_i > 0 && answer =~ /^\d+$/
    clear
    puts 'Please enter an integer greater than 0.'
  end
  answer.to_i
end

def game_amounts
  answer = nil
  clear
  loop do
    print 'What would you like to set the bust amount to: '
    answer = gets.chomp
    break if answer.to_i > 20 && answer.to_i < 72 && answer =~ /^\d+$/
    clear
    puts 'Please enter an integer 21 - 71.'
  end

  [answer.to_i, answer.to_i - 4]
end

def welcome_message
  clear
  puts 'Welcome to Twenty-One!'
  puts 'Press enter to begin.'
  gets
end

def goodbye_message
  clear
  puts 'Thank you for playing Twenty-One!'
  puts 'Goodbye!'
  sleep 2
  clear
end

welcome_message

loop do
  game = Game.new
  PLAY_UNTIL = score_amount.freeze
  BUST_AMOUNT, DEALER_CAP = game_amounts.freeze
  loop do
    loop do
      game.display
      game.player.hit_or_stay ? game.player.get_card(game.deck) : break
      break if calculate_total(game.player.cards) > BUST_AMOUNT
    end

    loop do
      break if calculate_total(game.player.cards) > BUST_AMOUNT
      game.display
      break if game.dealer.dealer_decision(game)
    end
    game.result
    break if game.end?
    game.restart(game.player, game.dealer)
  end
  game.display_winner
  break unless game.player.play_again?
end

goodbye_message
