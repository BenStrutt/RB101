arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

new = Hash.new
arr.each {|a| new[a[0]] = a[1]}
p new