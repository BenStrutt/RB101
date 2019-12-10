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
def valid_loan?(n)
  n.delete! '$,'
  return false unless n =~ /^\d+\.?\d*$/
  return false unless n.to_f > 0
  n.to_f
end

# Validates the user's input for APR amount and returns as a monthly rate
def valid_apr?(n)
  n.delete! '%'
  return false unless n =~ /^\d+\.?\d*$/
  (n.to_f / 100) / 12
end

# Validates the user's input for loan length and returns as a float
def valid_length?(n)
  return false unless n =~ /^\d+$/
  n.to_f
end

# Receives user input
def receive(input)
  value = false
  while value == false
    case input
    when 'loan_amount' then value = valid_loan?(user_input('loan_amount'))
    when 'apr' then value = valid_apr?(user_input('apr'))
    when 'loan_length' then value = valid_length?(user_input('loan_length'))
    end
    output 'invalid' if value == false
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
  loop do
    answer = user_input('again?').downcase
    return true if answer == 'yes' || answer == 'y'
    return false if answer == 'no' || answer == 'n'
    output 'invalid'
  end
end

def clear
  system('clear') || system('cls')
end

clear
output 'welcome'

loop do
  loan_amount = receive 'loan_amount'
  interest_rate = receive 'apr'
  loan_duration = receive 'loan_length'
  mortgage = calculate_mortgage(loan_amount, interest_rate, loan_duration)
  clear
  puts "-Your monthly mortgage is $#{mortgage}!"
  break unless another_calculation?
  clear
end

clear
output 'thanks'
