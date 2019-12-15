def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4
  dot_separated_words.each { |word| return false unless is_an_ip_number?(word) }
  return true
end