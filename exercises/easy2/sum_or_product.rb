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
  operator = gets.chomp
  break if %w(s p).include? operator
end

list_of_ints = [*1..num]
case operator
when 's'
  sum_or_product = 'sum'
  result = list_of_ints.sum
when 'p'
  sum_or_product = 'product'
  result = list_of_ints.reduce(:*)
end

puts "The #{sum_or_product} of the integers between 1 and #{num} is #{result}."

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