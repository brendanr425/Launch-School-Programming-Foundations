def marked_squares(arr)
  ["  #{arr[0]}  |  #{arr[1]}  |  #{arr[2]}",
   "  #{arr[3]}  |  #{arr[4]}  |  #{arr[5]}",
   "  #{arr[6]}  |  #{arr[7]}  |  #{arr[8]}"]
end

def detection(board, mark)
  return_value = false
  board_state(board).each do |sub|
    if sub.count(mark) == 2 && sub.any? { |ele| ele.class == Integer }
      board[board.index(sub.select { |ele| ele.class == Integer }[0])] = 'O'
      return_value = true
      break
    end
    next
  end
  return_value
end

# rubocop: disable Metrics/AbcSize

def board_state(board)
  [[board[0], board[1], board[2]],
   [board[3], board[4], board[5]],
   [board[6], board[7], board[8]],
   [board[0], board[3], board[6]],
   [board[1], board[4], board[7]],
   [board[2], board[5], board[8]],
   [board[0], board[4], board[8]],
   [board[2], board[4], board[6]]]
end

def blank_rows
  '     |     |     '
end

def lines
  '-----+-----+-----'
end

def display_board(arr)
  mark_index = 0
  13.times do |idx|
    puts blank_rows if [1, 3, 5, 7, 9, 11].include?(idx)
    if [2, 6, 10].include?(idx)
      puts marked_squares(arr)[mark_index]
      mark_index += 1
    end
    puts lines if [4, 8].include?(idx)
  end
end

def joinor(board, delimiter = ', ', last_delimiter = 'or')
  if board.length > 2
    last = "#{delimiter}#{last_delimiter} " + board.last.to_s
    board[0...-1].join(delimiter) + last
  elsif board.length == 2
    last = " #{last_delimiter} " + board.last.to_s
    board[0...-1].join(delimiter) + last
  else
    board[0].to_s
  end
end

def winner?(board, mark)
  answer = false
  winning_indices.each do |arr|
    new_arr = []
    arr.each { |ele| new_arr << board[ele] }
    if new_arr == [mark, mark, mark]
      answer = true
      break
    end
  end
  answer
end

def winning_indices
  [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
   [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
end

def player_choice(board)
  user_choice = nil
  loop do
    user_choice = gets.to_i
    clear
    break if not_invalid_or_taken(board, user_choice)
  end
  board[user_choice - 1] = 'X'
end

def computer_choice(board, player_mark, ai_mark)
  if !detection(board, ai_mark) && !detection(board, player_mark)
    if board[4] == 5
      board[4] = ai_mark
    else
      board[board.select { |ele| ele.class == Integer }.sample - 1] = ai_mark
    end
  end
end

def place_piece!(board, current_player, player_mark, computer_mark)
  case current_player
  when 'X'
    player_choice(board)
  when 'O'
    computer_choice(board, player_mark, computer_mark)
  end
end

def alternate_player(current_player)
  case current_player
  when 'X'
    'O'
  when 'O'
    'X'
  end
end

def display_end_results(arr, user_mark, computer_mark)
  if winner?(arr, user_mark)
    puts 'You win!'
  elsif winner?(arr, computer_mark)
    puts 'You lose!'
  else
    puts "It's a tie!"
  end
end

def taken?(board, idx)
  board[idx - 1] == 'X' || board[idx - 1] == 'O'
end

def valid_input?(input)
  (1..9).cover?(input)
end

def not_invalid_or_taken(board, player_choice)
  if !valid_input?(player_choice)
    display_board(board)
    puts 'Invalid input. Try again! (1-9)'
  elsif taken?(board, player_choice)
    display_board(board)
    puts "#{player_choice} was already chosen. Try again! (1-9)"
  else
    true
  end
end

def clear
  system('clear') || system('cls')
end

def full?(board)
  board.any? { |ele| ele.class == Integer } == false
end

def round_results(board, user_mark, computer_mark)
  if winner?(board, user_mark)
    puts 'You won the round! Press any key to continue.'
  elsif winner?(board, computer_mark)
    puts 'You lost this round. Press any key to continue.'
  else
    puts "It's a tie! Press any key to continue."
  end
end

def prompt_and_score(empty_squares, user_score, comp_score)
  puts "Choose a position to place a piece: #{joinor(empty_squares)}"
  puts "Player: #{user_score} | Computer: #{comp_score}"
end

board = nil
USER = 'X'.freeze
COMPUTER = 'O'.freeze
# rubocop: disable Metrics/BlockLength
loop do
  user_score = 0
  comp_score = 0

  loop do
    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    current_player = USER
    loop do
      clear
      display_board(board)
      empty_squares = board.select { |ele| ele.class == Integer }
      prompt_and_score(empty_squares, user_score, comp_score)

      place_piece!(board, current_player, USER, COMPUTER)
      current_player = alternate_player(current_player)
      break if winner?(board, USER) || winner?(board, COMPUTER) || full?(board)
    end

    clear
    display_board(board)
    round_results(board, USER, COMPUTER)

    user_score += 1 if winner?(board, USER)
    comp_score += 1 if winner?(board, COMPUTER)

    puts "Player: #{user_score} | Computer: #{comp_score}"
    gets

    break if comp_score == 5 || user_score == 5
  end

  clear
  display_board(board)
  display_end_results(board, USER, COMPUTER)
  puts "Press 'Y' to play again or any other key to quit."
  play_again = gets.chomp
  break unless play_again.casecmp?('y')
end

clear
puts 'Thank you for playing!'
