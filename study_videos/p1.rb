# Define a method that takes a string as an argument and returns the reversed
# string without using #reverse method.

def reverse_string(str)
  (1..str.size).map { |ind| str[-ind] }.join
end

p reverse_string("Hello there!")