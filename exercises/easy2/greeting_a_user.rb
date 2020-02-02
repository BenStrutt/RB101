# Write a program that will ask for user's name. The program will then greet the
# user. If the user writes "name!" then the computer yells back to the user.

print "What is your name? "
name = gets.chomp

if name.chars.last == '!'
  puts "HELLO #{name.upcase[0..-2]}. WHY ARE WE SCREAMING?"
else
  puts "Hello #{name}."
end

# What is your name? Bob
# Hello Bob.

# What is your name? Bob!
# HELLO BOB. WHY ARE WE SCREAMING?