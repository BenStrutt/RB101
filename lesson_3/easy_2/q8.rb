advice = "Few things in life are as important as house training your pet dinosaur."

advice.chomp!(' house training your pet dinosaur.')

advice = "Few things in life are as important as house training your pet dinosaur."

return_value = advice.slice!(0..38)
p advice
p return_value

# advice.slice!(0, advice.index('house')) is better as per the solution