# Write a program that will ask a user for an input of a word or multiple words
# and give back the number of characters. Spaces should not be counted as a character.

print 'Please enter word or multiple words: '
answer = gets.chomp
puts "There are #{answer.gsub(' ', '').length} characters in '#{answer}'."