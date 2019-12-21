arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

p arr.map(&:sort).map(&:reverse)