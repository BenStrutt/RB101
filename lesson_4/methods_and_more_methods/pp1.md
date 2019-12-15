The return value will be the original array, since the 'selesct' method
evaluates the truthiness of the blocks return value. In this case, the block
returns 'hi' each time, which is 'truthy' in Ruby, so the 'select' method
selects each element in the array and returns them.