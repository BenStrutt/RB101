The return value of the code will be a new array that is the same as the
original array. This is because the 'reject' method works like the opposite
of the 'select' method, and keeps values where the block doesn't return a
'truthy' value. In this case, the block returns 'nil' each time (as a result
of calling the 'puts' method in the final line), so it keeps each value in the
array.