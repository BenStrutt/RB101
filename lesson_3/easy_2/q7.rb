flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones += %w(Dino Hoppy)
p flintstones

# another option
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push('Dino', 'Hoppy')
p flintstones

# another option
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.concat(%w(Dino Hoppy))
p flintstones