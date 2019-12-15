def array_to_hash(array)
  array.each_with_index { |v, i| array[i] = [v, i] }.to_h
end

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones = array_to_hash(flintstones)

p flintstones