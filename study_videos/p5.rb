# Write a method that takes a string and returns a boolean if the string has
# a balanced set of parentheses.

def balanced_parentheses?(string)
  string_array = string.chars
  paren_count = 0
  paren_values = { '(' => 1, ')' => -1 }
  string_array.each do |char|
    paren_count += paren_values[char] if paren_values.keys.include?(char)
    return false if paren_count < 0
  end
  paren_count == 0
end

p balanced_parentheses?('Well h()el)lo there')