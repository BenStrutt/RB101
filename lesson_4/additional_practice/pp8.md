The first code will output:
1
3

This is because we are altering the array as we iterate over it. At the end of
the first iteration we are removing the first value of the array. This means
that when the loop goes to access the second value at index '1', that value is
now what was previously the third value at index '2'.

The second code will output:
1
2

This is for a similar reason to the first code. In this instance, the loop is
removing the last value of the array at the end of each iteration, so after two
loops through there are no more values to loop over. The array looks like the 
following at the beginning of each iteration.

Array: [1, 2, 3, 4]

0)
Output: 1
Array: [1, 2, 3]

1)
Output: 2
Array: [1, 2]

Loop ends as there is no index '2' to iterate over.