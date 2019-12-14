flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

# 'un-nests' the array.
flintstones.flatten!

p flintstones