flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

p flintstones.find_index { |v| v.start_with?('Be') }