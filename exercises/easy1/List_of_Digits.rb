# Write a method that takes one argument, a positive integer, and returns a list of the digits in the number.

def digit_list(int)
  int.digits.reverse
end

p digit_list(12345)

