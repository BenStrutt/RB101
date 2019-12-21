arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

new = arr.map {|arr| arr.select {|i| i % 3 == 0}}

p new