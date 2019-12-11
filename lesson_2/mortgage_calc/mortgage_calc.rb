require 'yaml'

MESSAGE = YAML.load(File.open('.config.yml'))

# Outputs messages to screen
def output(key)
  puts '-' + MESSAGE[key]
end

# Receives and returns input from user
def user_input(key)
  output key
  print '-> '
  gets.chomp
end

# Validates the user's input for loan amount and returns as a float
def validate_loan(n)
  n.delete! '$,'
  return 'not_number' unless n =~ /^\d+\.?\d*$/
  return 'zero' unless n.to_f > 0
  n.to_f
end

# Validates the user's input for APR amount and returns as a monthly rate
def validate_apr(n)
  n.delete! '%'
  return 'not_number' unless n =~ /^\d+\.?\d*$/
  return 'zero' unless n.to_f > 0
  (n.to_f / 100) / 12
end

# Validates the user's input for loan length and returns as a float
def validate_length(n)
  return 'not_number' unless n =~ /^\d+$/
  return 'zero' unless n.to_f > 0
  n.to_f
end

def user_input_error?(answer)
  true if answer == 'zero' || answer == 'not_number'
end

def error_message(key)
  output 'zero' if key == 'zero'
  output 'not_number' if key == 'not_number'
  output 'yes_or_no' if key == 'yes_or_no'
end

def receive_user_input(key)
  value = ''
  loop do
    value = get_value(key)
    break unless user_input_error?(value)
    clear
    error_message(value)
  end
  clear
  value
end

def get_value(key)
  case key
  when 'loan_amount' then value = validate_loan(user_input('loan_amount'))
  when 'apr' then value = validate_apr(user_input('apr'))
  when 'loan_length' then value = validate_length(user_input('loan_length'))
  end
  value
end

# Calculates the user's mortgage
def calculate_mortgage(amount, interest, length)
  mortgage = amount * (interest / (1 - (1 + interest)**-length))
  format_mortgage(mortgage.round(2).to_s)
end

# Format's the calculated mortgage as a more readable string
def format_mortgage(mortgage)
  mortgage.length > 6 ? mortgage.insert(-7, ',') : mortgage
end

# Asks the user whether they'd like to calculate again
def another_calculation?
  answer = ''
  loop do
    answer = user_input('again?').downcase
    break if valid_play_again?(answer)
    clear
    error_message 'yes_or_no'
  end
  answer == 'yes' || answer == 'y'
end

def valid_play_again?(answer)
  %w(y yes n no).each { |n| return true if n == answer }
  false
end

def clear
  system('clear') || system('cls')
end

clear
output 'welcome'

loop do
  loan_amount = receive_user_input 'loan_amount'
  interest_rate = receive_user_input 'apr'
  loan_duration = receive_user_input 'loan_length'
  mortgage = calculate_mortgage(loan_amount, interest_rate, loan_duration)
  clear
  puts "-Your monthly mortgage is $#{mortgage}!"
  break unless another_calculation?
  clear
end

clear
output 'thanks'
