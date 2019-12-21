hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

vowels = %w(a e i o u)
hsh.each {|_,v| v.each {|w| w.chars.each {|c| puts c if vowels.include? c}}}