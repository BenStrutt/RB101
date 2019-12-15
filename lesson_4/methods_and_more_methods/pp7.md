The block's return value in the code is 'true', because it only gets through one
iteration. The 'any?' method breaks and returns 'true' as soon as the block of
code returns a 'truthy' value. In this case, it returns 'true' on the first
iteration because 1 is an odd number. If it reached the second iteration it
would return 'false'.

The 'any' method in this case returns 'true', because it reached an iteration
where the block returned a 'truthy' value.

The code outputs only the integer '1', because it only got through one
iteration.