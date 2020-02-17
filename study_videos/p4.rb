# Write a method that takes an array of strings, and returns an array of the
# same string values, except with the vowels removed.

def remove_vowels(string_array)
  string_array.map { |word| word.gsub(/[aeiou]/, '') }
end

p remove_vowels(['green', 'yellow', 'black', 'white'])