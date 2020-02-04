#
# No longer functional code. Attempted to add many more features and gave up
# after a while. Leaving the remnants here because I believe that there is
# useful stuff here.
#

# frozen_string_literal: true

require 'pry'

$mmruns = 0
MARKER_VALUES = { ' ' => 'a', 'X' => 'b', 'O' => 'c' }.freeze

def clear
  system('clear') || system('cls')
end

def initialize_board(size)
  board = {}
  (1..(size * size)).each { |num| board[num] = ' ' }
  board
end

def get_board_state_hash(board)
  temp_board = board.clone
  hash_list = []
  (1..8).each do |i|
    board_hash = ''
    temp_board.each { |_, v| board_hash += MARKER_VALUES[v] }
    hash_list << board_hash
    temp_board = orient_board(temp_board, 'rotate')
    temp_board = orient_board(temp_board, 'flip') if i == 4
  end
  hash_list.min
end

def orient_board(board, permutation)
  size = Math.sqrt(board.size).to_i
  new_board = board.clone
  orient_algorithm(size, permutation, board, new_board)
end

def orient_algorithm(size, permutation, board, new_board)
  square = 1
  (0...size).each do |row|
    (0...size).each do |column|
      algo = size + ((size * row) - column) if permutation == 'flip'
      algo = (size - row) + (size * column) if permutation == 'rotate'
      new_board[algo] = board[square]
      square += 1
    end
  end
  new_board
end

def determine_outcome(board)
  temp_board = board.clone
  size = Math.sqrt(board.length).to_i
  4.times do
    win = check_for_win(temp_board, size)
    return win if win

    temp_board = orient_board(temp_board, 'rotate')
  end
  return 0 if board.select { |_, v| v == ' ' }.empty?

  nil
end

def check_for_win(board, size)
  row_win = check_row_for_win(board, size)
  return row_win if row_win

  check_diagonal_for_win(board, size)
end

def check_row_for_win(board, size)
  length = [3, 5].include?(size) ? 3 : 4
  wins_across = [3, 5].include?(size) ? size - 2 : size - 3
  rows_to_check = (size / 2) + 1
  row_win(board, length, wins_across, rows_to_check, size)
end

def row_win(board, length, wins_across, rows_to_check, size)
  row = 0
  rows_to_check.times do
    wins_across.times do |i|
      start = row + i
      return 500 if board.values[start...(start + length)].all?('X')
      return -500 if board.values[start...(start + length)].all?('O')
    end
    row += size
  end
  nil
end

def check_diagonal_for_win(board, size)
  length = [3, 5].include?(size) ? 3 : 4
  starts = diagonal_starting_squares(size)
  diagonal_win(starts, board, length, size)
end

def diagonal_starting_squares(size)
  case size
  when 3 then [1]
  when 5 then [1, 7]
  when 7 then [1, 9, 17]
  when 9 then [1, 11, 21]
  end
end

def diagonal_win(starts, board, length, size)
  starts.each do |square|
    diagonal = []
    length.times do
      diagonal << board[square]
      square += size + 1
    end
    return 500 if diagonal.all?('X')
    return -500 if diagonal.all?('O')
  end
  nil
end

def computer_places_peice(board, permutations)
  permutations = {}
  move_evals = board.select { |_, value| value == ' ' }
  move_evals.keys.each do |square|
    move_evals[square] = get_move_eval(board, square, permutations)
  end
  board[move_evals.select { |_, v| v == move_evals.values.min }.keys[0]] = 'O'
end

def get_move_eval(board, square, permutations)
  temp = board.clone
  temp[square] = 'O'
  hash = get_board_state_hash(temp)
  if permutations.keys.include?(hash)
    permutations[hash]
  else
    value = minimax(temp, 0, -1000, 1000, permutations)
    permutations[hash] = value
    value
  end
end

def minimax(board, depth, alpha, beta, permutations)
  board_outcome = get_board_evaluation(board, permutations)
  return board_outcome if board_outcome
  return calculate_ongoing_game(board) if depth > 3
  $mmruns += 1
  puts $mmruns if $mmruns % 1000 == 0
  binding.pry if $mmruns == 15000

  hash = get_board_state_hash(board)
  available_squares = board.select { |_, v| v == ' ' }.keys
  turn = available_squares.length.even? ? 'comp' : 'plyr'
  marker, optimum_value = turn == 'plyr' ? ['X', -1000] : ['O', 1000]
  passing = [available_squares, turn, marker, optimum_value, depth]
  optimum_value = get_optimum_value(board, alpha, beta, permutations, passing)
  permutations[hash] = optimum_value
  optimum_value
end

def get_optimum_value(board, alpha, beta, permutations, passing)
  available_squares, turn, marker, optimum_value, depth = passing
  available_squares.each do |square|
    temp_board = board.clone
    temp_board[square] = marker
    eval = minimax(temp_board, depth + 1, alpha, beta, permutations)
    optimum_value = evaluate_optimum_value([optimum_value, eval], turn)
    alpha, beta = get_alpha_beta(alpha, beta, optimum_value, turn)
    break if beta <= alpha
  end
  optimum_value
end

def evaluate_optimum_value(values, turn)
  turn == 'plyr' ? values.max : values.min
end

def get_alpha_beta(alpha, beta, optimum_value, turn)
  if turn == 'plyr'
    [[alpha, optimum_value].max, beta]
  else
    [alpha, [beta, optimum_value].min]
  end
end

def get_board_evaluation(board, permutations)
  hash = get_board_state_hash(board)
  return permutations[hash] if permutations.keys.include?(hash)

  determine_outcome(board)
end

def populate_square_values(board)
  values = get_square_values(board)
  strength = 1
  board.keys.each do |square|
    temp_board = board.clone
    temp_board[square] = 'X'
    values[square], strength = add_square_strength(temp_board, strength, values)
  end
  values
end

def add_square_strength(board, strength, values)
  (1..8).each do |i|
    current_square = board.select { |_, v| v == 'X' }.keys[0]
    unless values[current_square] == ' '
      return [values[current_square], strength]
    end

    board = orient_board(board, 'rotate')
    board = orient_board(board, 'flip') if i == 4
  end
  [strength, strength += 1]
end

def get_square_values(board)
  size = Math.sqrt(board.size).to_i
  values = board.clone
  case size
  when 3 then square_values = three_by_three_values
  when 5 then square_values = five_by_five_values
  when 7 then square_values = seven_by_seven_values
  when 9 then square_values = nine_by_nine_values
  end
  square_values.each { |square, value| values[square] = value }
  values
end

def three_by_three_values
  { 1 => 2, 2 => 1, 5 => 3 }
end

def five_by_five_values
  { 1 => 1, 2 => 2, 3 => 3, 7 => 4, 8 => 5, 13 => 6 }
end

def seven_by_seven_values
  {
    1 => 1, 2 => 2, 3 => 3, 4 => 4, 9 => 3,
    10 => 4, 11 => 5, 17 => 6, 18 => 7, 25 => 8
  }
end

def nine_by_nine_values
  {
    1 => 1, 2 => 2, 3 => 3, 4 => 5, 5 => 5, 11 => 4, 12 => 6, 13 => 7,
    14 => 7, 21 => 8, 22 => 9, 23 => 9, 31 => 10, 32 => 10, 41 => 10
  }
end

def draw_lines(size, space, intersection)
  print ' '
  (1..size).each do |i|
    print space * (size + 2)
    print intersection unless i == size
  end
  puts ' '
end

def draw_pieces(board, size, square, y_coords)
  print y_coords
  (1..size).each do |i|
    print ' ' * ((size + 2) / 2)
    print board[square]
    print ' ' * ((size + 2) / 2)
    square += 1
    print '|' unless i == size
  end
  puts ''
  square
end

def display_board(board)
  size = Math.sqrt(board.size).to_i
  y_coords = size
  square = 1
  puts ' '
  draw_board_lines(board, size, square, y_coords)
  draw_x_coords(size)
  puts ' '
end

def draw_x_coords(size)
  coordinate = 'a'
  print ' '
  (1..size).each do |i|
    print ' ' * ((size + 2) / 2)
    print coordinate
    print ' ' * ((size + 2) / 2)
    print ' ' unless i == size
    coordinate = coordinate.next
  end
end

def draw_board_lines(board, size, square, y_coords)
  (1..((size * 3) + (size - 1))).each do |i|
    draw_lines(size, '-', '+') if (i % 4).zero?
    draw_lines(size, ' ', '|') if i.odd?
    next unless i.even? && i % 4 == 2

    draw_pieces(board, size, square, y_coords)
    square += size
    y_coords -= 1
  end
end

def calculate_ongoing_game(board)
  x_strength = 0
  o_strength = 0
  board.each do |square, piece|
    x_strength += SQUARE_VALUES[square] if piece == 'X'
    o_strength += SQUARE_VALUES[square] if piece == 'O'
  end
  x_strength - o_strength
end

def coordinate_to_square(coordinate, size)
  x_coord, y_coord = coordinate.chars
  y_coord = y_coord.to_i
  x_coord = size - (x_coord.downcase.ord - 96)
  (x_coord * size) + y_coord
end

def player_places_piece(board)
  size = Math.sqrt(board.size).to_i
  print "Pick a square using coordinates (e.g. 'd4'): "
  board[coordinate_to_square(gets.chomp, size)] = 'X'
end

puts 'Size?'
print '> '
size = gets.chomp.to_i
board = initialize_board(size)
SQUARE_VALUES = populate_square_values(board).freeze
permutations = {}

loop do
  clear
  display_board(board)
  player_places_piece(board)
  outcome = determine_outcome(board)
  break if outcome

  computer_places_peice(board, permutations)
  outcome = determine_outcome(board)
  break if outcome

  binding.pry
end
