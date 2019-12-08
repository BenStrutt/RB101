require 'pry'
require 'yaml'

message = YAML.load(File.open('.config.yml'))

def input
  print '> '
end

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
input

name = ''
loop do
  name = gets.chomp
  break unless name.empty?
  prompt message['valid_name']
  input
end

prompt "Hi #{name}"

loop do
  num1 = ''
  loop do
    prompt message['first_num']
    input
    num1 = gets.chomp
    break unless number?(num1).nil?
    prompt message['valid_num']
  end

  num2 = ''
  loop do
    prompt message['second_num']
    input
    num2 = gets.chomp
    break unless number?(num2).nil?
    prompt message['valid_num']
  end

  prompt message['operator_prompt']

  operator = ''
  loop do
    input
    operator = gets.chomp
    break unless (%w(1 2 3 4).include? operator) != true
    prompt message['valid_op']
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
  input
  break unless gets.chomp.downcase.start_with?('y')
end

prompt message['thanks']
