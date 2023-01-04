# frozen-string-literal: true

require_relative 'player'
require_relative 'board'

# Logo Message
def print_title
  puts '
  █▀▀ █▀█ █▄░█ █▄░█ █▀▀ █▀▀ ▀█▀
  █▄▄ █▄█ █░▀█ █░▀█ ██▄ █▄▄ ░█░

  █▀▀ █▀█ █░█ █▀█
  █▀░ █▄█ █▄█ █▀▄'
  puts '
  The first player to connect four of 
  their discs horizontally, vertically, or 
  diagonally wins the game.
  '
end

print_title

# Create board
board = Board.new
# Print board
board.print_board

# Create player one
player_one = Player.new
# Ask for player 1's name
player_one.gets_name
# Ask for player 1's choice of ascii logo
player_one.update_symbol

# Create player two
player_two = Player.new
# Ask for player 2's name
player_two.gets_name
# Ask for player 2's choice of ascii logo
player_two.symbol = '☺' if player_one.symbol == '☻'
player_two.symbol = '☻' if player_one.symbol == '☺'

# Loop until Winning condition is reached
loop do
  # Update board with player one's move
  board.update_board(player_one)
  # Print the board
  board.print_board
  # Check if it is winning move
  if board.winning_move?(player_one)
    puts "#{player_one.name} is the winner!"
    break
  end

  # Update board with player two's move
  board.update_board(player_two)
  # Print the board
  board.print_board
  # Check if it is winning move
  if board.winning_move?(player_two)
    puts "#{player_two.name} is the winner!"
    break
  end
end
