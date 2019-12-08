require 'pry'
require 'yaml'

message = YAML.load(File.open('.config.yml'))

def prompt(message)
  puts "=> #{message}"
end

def number?(num)
  return true if num =~ /^\d+$/ || num =~ /^\d*\.\d*$/
end

def to_?(num)
  return num.to_i if num =~ /^\d+$/
  return num.to_f if num =~ /^\d*\.\d*$/
end

def operation_to_message(op)
  case op
  when '1' then 'Adding'
  when '2' then 'Subtracting'
  when '3' then 'Multiplying'
  when '4' then 'Dividing'
  end
end

prompt message['welcome']

name = ''

loop do
  name = gets.chomp
  if name.empty? then prompt message['valid_name'] else break end
end

prompt "Hi #{name}"

loop do
  num1 = ''
  loop do
    prompt message['first_num']
    num1 = gets.chomp
    
    if number? num1
      break
    else
      prompt message['valid_num']
    end
  end
  
  num2 = ''
  loop do
    prompt message['second_num']
    num2 = gets.chomp
    
    if number? num2
      break
    else
      prompt message['valid_num']
    end
  end
  
  # operator_prompt = <<-MSG
    # What operation would you like to perform? 
    # 1) add 
    # 2) subtract 
    # 3) multiply 
    # 4) divide
  # MSG
  
  prompt message['operator_prompt']
  
  operator = ''
  loop do
    print "=> "
    operator = gets.chomp
    
    if %w(1 2 3 4).include? operator
      break
    else
      prompt message['valid_op']
    end
  end
  
  prompt "#{operation_to_message(operator)} the two numbers..."
  
  result = case operator
           when '1' then to_?(num1) + to_?(num2)
           when '2' then to_?(num1) - to_?(num2)
           when '3' then to_?(num1) * to_?(num2)
           when '4' then to_?(num1) / to_?(num2)
           end
  
  prompt "The result is #{result}"
  
  prompt message['another']
  print "=> "
  break unless gets.chomp.downcase().start_with?('y')
end

prompt message[thanks]