require 'pry'

def century(n)
  suffixes = %w(th st nd rd th th th th th th)
  century = ((n - 1) / 100) + 1
  if century.to_s.end_with?('11', '12', '13') then suffix = suffixes[0]
  else suffix = suffixes[century.digits.first]
  end
  century.to_s + suffix
end

p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201)