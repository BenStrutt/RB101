# Write a program that asks the user to enter an integer greater than 0, then asks
# if the user wants to determine the sum or product of all numbers between 1 and the entered integer.

num = ''
loop do
  puts "Please enter an integer greater than 0:"
  num = gets.chomp.to_i
  break if num > 0
end

operator = ''
loop do
  puts "Enter 's' to compute the sum, 'p' to compute the product."
  operator = ''
  break if %w(s p).include? operator
end

# >> Please enter an integer greater than 0:
# 5
# >> Enter 's' to compute the sum, 'p' to compute the product.
# s
# The sum of the integers between 1 and 5 is 15.


# >> Please enter an integer greater than 0:
# 6
# >> Enter 's' to compute the sum, 'p' to compute the product.
# p
# The product of the integers between 1 and 6 is 720.