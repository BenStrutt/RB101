# Write a method that takes two numbers. It should print out all primes between
# the two numbers. Don't use Ruby's prime class

def find_primes(start, finish)
  result = (start..finish).select do |num|
    is_prime = true
    (2...num).each do |i|
      is_prime = false if num % i == 0
    end
    is_prime
  end
  puts result.join(', ')
end

find_primes(3, 18)