statement = "The Flintstones Rock"

p statement.delete(' ').chars.each_with_object(Hash.new(0)){|k,h| h[k] += 1}