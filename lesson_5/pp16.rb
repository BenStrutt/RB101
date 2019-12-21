require 'securerandom'

def uuid_generator1
  uuid = []
  count = 0
  loop do
    if [8, 13, 18, 23].include? count
      uuid << '-'
      count += 1
      next
    end
    uuid << rand(0..15)
    count += 1
    break if count == 36
  end
  uuid.map! {|v| (v.is_a? Integer) ? v.to_s(16) : v}.join
end

def uuid_generator2
  SecureRandom.uuid
end

p uuid_generator1
p uuid_generator2
