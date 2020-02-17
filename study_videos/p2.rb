# Write a method that takes two arguments. The first is the starting number,
# the second is the ending number. Print out all the numbers
# between the two numbers (incliusive) except print 'fizz' if the number is
# divisible by 3, 'buzz' if the number is divisible by 5, 'fizzbuzz' if the
# number is divisible by both.

def fizzbuzz(first_num, last_num)
  (first_num..last_num).map do |num|
    output = ''
    output += 'Fizz' if num % 3 == 0
    output += 'Buzz' if num % 5 == 0
    output == '' ? num : output
  end.join(", ")
end

p fizzbuzz(2, 20)