def titleize(string)
  string.split.map {|w| w.capitalize}.join(' ')
end

words = "the flintstones rock"
words = titleize(words)

p words