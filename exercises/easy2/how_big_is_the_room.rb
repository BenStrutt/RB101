# Build a program that asks a user for the length and width of a room in meters
# and then displays the area of the room in both square meters and square feet.

puts "Enter the length of the room in meters:"
length = gets.chomp.to_i

puts "Enter the width of the room in meters:"
width = gets.chomp.to_i

sq_meters = (length * width).round
sq_feet = (sq_meters * 10.7639).round

puts "The area of the room is #{sq_meters} square meters " + \
     "(#{sq_feet} square feet)."


# Enter the length of the room in meters:
# 10
# Enter the width of the room in meters:
# 7
# The area of the room is 70.0 square meters (753.47 square feet).