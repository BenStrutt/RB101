Used the documentation at:
https://ruby-doc.org/core-2.6.5/Enumerable.html#method-i-each_with_object

In the given code the 'value' variable will be a string from the given array.
The 'hash' variable will be the empty hash initialized as an argument given
to the 'each_with_object' method.

First time through, the hash will be {'a' => 'ant'}
Second will be {'a' => 'ant', 'b' => 'bear'}
Third {'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}