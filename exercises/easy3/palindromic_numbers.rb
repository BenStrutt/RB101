# Write a method that returns true if its integer argument is palindromic, false
# otherwise. A palindromic number reads the same forwards and backwards.

def palindromic_number?(number)
  number.digits == number.digits.reverse
end

p palindromic_number?(34543) == true
p palindromic_number?(123210) == false
p palindromic_number?(22) == true
p palindromic_number?(5) == true