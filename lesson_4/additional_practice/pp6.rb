flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! { |v| v[0, 3] }

p flintstones