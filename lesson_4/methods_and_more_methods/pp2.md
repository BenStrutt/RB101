We can find out how the 'count' method treats the block's return value by
looking at the documentation for the method. I've found the documentation at:
https://ruby-doc.org/core-2.6/Array.html#method-i-count

The 'count' method iterates over each value and checks whether the return value
is 'truthy'. It returns the amount of times that the return value was 'truthy'.

The code in the Practice Problem will return the integer '2'.