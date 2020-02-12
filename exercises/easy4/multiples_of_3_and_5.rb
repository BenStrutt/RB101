# Write a method that searches for all multiples of 3 or 5 that lie between 1
# and some other number, and then computes the sum of those multiples.

def multisum(n)
  [*1..n].select { |i| i % 3 == 0 || i % 5 == 0 }.sum
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168