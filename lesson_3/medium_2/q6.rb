VALID_COLORS = %w(blue green)

def color_valid(color)
  VALID_COLORS.include? color
end

=begin
Better method as per solution:

def color_valid(color)
  color == "blue" || color == "green"
end
=end