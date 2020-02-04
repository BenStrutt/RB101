# Write a program that solicits 6 numbers from the user, then prints a message that
# describes whether or not the 6th number appears amongst the first 5 numbers.

numbers = []
%w(1st 2nd 3rd 4th 5th last).each do |i|
  puts "Please enter the #{i} numer:"
  numbers << gets.chomp.to_i
end

compare = numbers.pop
if numbers.include?(compare)
  puts "The number #{compare} appears in #{numbers}."
else puts "The number #{compare} does not appear in #{numbers}."
end