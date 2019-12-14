def factors(number)
  factors = []
  for i in (1..number) do factors << number / i if number % i == 0 end
  factors
end

p factors(45)

# 1) Tells you if the divisor goes into the number evenly, which makes it a factor.
# 2) Returns the list of factors.