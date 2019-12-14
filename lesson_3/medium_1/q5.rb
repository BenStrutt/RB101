limit = 15

def fib(first_num, second_num, limit)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"

=begin
The method wasn't able to access the 'limit' variable because it was declared
outside the method. We can fix it by passing it into the method as an argument.
=end