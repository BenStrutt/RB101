# Build a program that displays when the user will retire and how many years she has to work till retirement.

print "What is your age? "
age = gets.chomp.to_i

print "At what age would you like to retire? "
retirement = gets.chomp.to_i

puts "It's 2020. You will retire in #{2020 + (retirement - age)}."
puts "You only have #{retirement - age} years of work to go!"

# What is your age? 30
# At what age would you like to retire? 70

# It's 2016. You will retire in 2056.
# You have only 40 years of work to go!