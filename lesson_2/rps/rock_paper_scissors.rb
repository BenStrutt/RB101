require 'yaml'

MESSAGE = YAML.load(File.open('.messages.yml')).freeze
VALID_CHOICES = %w(rock r paper p scissors s spock sp lizard l).freeze
CHOICE_TRANSLATE = {
  r: 'rock',
  p: 'paper',
  s: 'scissors',
  sp: 'spock',
  l: 'lizard'
}.freeze
CHOICE_BEATS = {
  rock: %w(scissors lizard),
  paper: %w(rock spock),
  scissors: %w(paper lizard),
  spock: %w(scissors rock),
  lizard: %w(paper spock)
}.freeze

def clear
  system('clear') || system('cls')
end

def find_result(player, computer)
  return 'draw' if player == computer.to_sym
  CHOICE_BEATS[player].include?(computer) ? 'win' : 'loss'
end

def output(key)
  puts "- #{MESSAGE[key]}"
end

def receive_input(key)
  output key
  print ': '
  gets.chomp
end

def valid_play_again?(answer)
  %w(y yes n no).each.include?(answer)
end

def play_again?
  answer = ''
  loop do
    answer = receive_input 'play_again?'
    break if valid_play_again?(answer)
    clear
    output 'invalid'
  end
  answer == 'yes' || answer == 'y'
end

def update_score(result, wins)
  wins[:player] += 1 if result == 'win'
  wins[:computer] += 1 if result == 'loss'
end

def display_score(wins)
  puts "- Score: You - #{wins[:player]} | Computer - #{wins[:computer]}"
end

def display_winner(wins)
  output wins[:player] == 5 ? 'match_won' : 'match_lost'
end

clear
output 'welcome'

loop do
  wins = { player: 0, computer: 0 }
  loop do
    choice = ''
    loop do
      choice = receive_input 'make_choice'
      break if VALID_CHOICES.include? choice
      clear
      output 'invalid'
    end

    CHOICE_TRANSLATE.each { |k, v| choice = v.to_sym if choice.to_sym == k }
    computer_choice = %w(rock paper scissors spock lizard).sample
    clear
    puts "- You chose: #{choice}; Computer chose: #{computer_choice}"
    result = find_result(choice, computer_choice)
    output result
    update_score(result, wins)
    display_score(wins)
    break if wins[:player] == 5 || wins[:computer] == 5
  end

  clear
  display_score(wins)
  display_winner(wins)
  break unless play_again?
  clear
end

clear
output 'thanks'
sleep 2
clear
