arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

p arr.sort_by {|i| i.select(&:odd?)}