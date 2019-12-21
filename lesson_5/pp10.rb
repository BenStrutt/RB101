arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

new = arr.map do |hash|
  temp = Hash.new
  hash.each {|k,v| temp[k] = v + 1}
  temp
end

p arr
p new