=begin
The result of the statement will be an error because '(40 + 2)' is not
interpreted as a string and Ruby won't be able to interpret the
concatation.
=end

puts "the value of 40 + 2 is #{(40 + 2)}"
puts "the value of 40 + 2 is " + (40 + 2).to_s