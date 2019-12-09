require 'yaml'

MESSAGE = YAML.load(File.open('.config.yml'))

def out(key)
  puts '-' + MESSAGE[key]
end

def user_in(key)
  puts '-' + MESSAGE[key]
  print '-> '
  gets.chomp
end

def valid_loan?(n)
  n = n.delete('$')
  n = n.delete(',')
  return false unless n =~ /^\d+\.?\d*$/
  n.to_f
end

def valid_apr?(n)
  n = n.delete('%')
  return false unless n =~ /^\d+\.?\d*$/
  (n.to_f / 100) / 12
end

def valid_length?(n)
  return false unless n =~ /^\d+$/
  n.to_f
end

def user_input(key)
  output = ''
  loop do
    output = user_in(key)
    case key[-1]
    when 't' then break if output = valid_loan?(output)
    when 'r' then break if output = valid_apr?(output)
    when 'h' then break if output = valid_length?(output)
    end
    out 'invalid'
  end
  output
end

def format_mortgage(n)
  n.length > 6 ? n.insert(-7, ',') : n
end

out 'welcome'

loop do
  loan_amount = user_input 'get_loan_amount'
  interest = user_input 'get_apr'
  loan_length = user_input 'get_loan_length'
  mortgage = loan_amount * (interest / (1 - (1 + interest)**-loan_length))
  mortgage = mortgage.round(2) if mortgage.is_a? Float
  puts "Your monthly mortgage is $#{format_mortgage(mortgage.to_s)}."
  break unless user_in('again?').downcase.start_with?('y')
end

out 'thanks'
