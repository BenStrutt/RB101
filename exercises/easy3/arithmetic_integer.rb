# Write a program that prompts the user for two positive integers, and then prints
# the results of the following operations on those two numbers: addition, subtraction,
# product, quotient, remainder, and power. Do not worry about validating the input.

numbers = {}
%w(1st 2nd).each do |i|
  puts "Please enter the #{i} number:"
  numbers[i] = gets.chomp.to_i
end

%w(+ - * / % **).each do |i|
  result = eval("#{numbers['1st']} #{i} #{numbers['2nd']}")
  puts "#{numbers['1st']} #{i} #{numbers['2nd']} = #{result}"
end