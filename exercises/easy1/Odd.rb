# Write a method that takes one integer argument, which may be positive, negative, or zero.
# This method returns true if the number's absolute value is odd. You may assume that the argument is a valid integer value.

def is_odd? int
  !(int % 2).zero?
end

p is_odd? 5