The return value of the 'map' method will be [nil, 'bear']. This is because
the 'map' method assigns the return value to the value of the iteration that it
is on. In the first iteration, the block of code returns 'nil', and the 'map'
method assigns that value. The second iteration returns 'bear', and the 'map'
method assigns that value.