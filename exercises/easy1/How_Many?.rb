# Write a method that counts the number of occurrences of each element in a given array.

def count_occurrences(array)
  result = {}
  array.uniq.each { |vehicle| result[vehicle] = array.count(vehicle) }
  result
end
  
vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

p count_occurrences(vehicles)