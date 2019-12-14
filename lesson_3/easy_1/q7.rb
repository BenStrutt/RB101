def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }

=begin
'eval(how_deep)' will return 42 because it evaluates Ruby expressions in
strings.  It will return '42' because it evaluates it as code and adds '8' to
'number' 5 times.
=end
p eval(how_deep)