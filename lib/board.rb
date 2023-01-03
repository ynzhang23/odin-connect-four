# frozen-string-literal: true

# Handles board creation with player positions, move 
# verification and winning-condition
class Board
  attr_reader :win_condition, :player
  attr_accessor :columns

  def initialize
    @columns = create_board
  end

  def create_board
    {
      '1' => [],
      '2' => [],
      '3' => [],
      '4' => [],
      '5' => [],
      '6' => [],
      '7' => []
    }
  end

  def print_board
    one = @columns['1']
    two = @columns['2']
    three = @columns['3']
    four = @columns['4']
    five = @columns['5']
    six = @columns['6']
    seven = @columns['7']

    puts "
    6 #{one[5]} #{two[5]} #{three[5]} #{four[5]} #{five[5]} #{six[5]} #{seven[5]}
    5 #{one[4]} #{two[4]} #{three[4]} #{four[4]} #{five[4]} #{six[4]} #{seven[4]}
    4 #{one[3]} #{two[3]} #{three[3]} #{four[3]} #{five[3]} #{six[3]} #{seven[3]}
    3 #{one[2]} #{two[2]} #{three[2]} #{four[2]} #{five[2]} #{six[2]} #{seven[2]}
    2 #{one[1]} #{two[1]} #{three[1]} #{four[1]} #{five[1]} #{six[1]} #{seven[1]}
    1 #{one[0]} #{two[0]} #{three[0]} #{four[0]} #{five[0]} #{six[0]} #{seven[0]}
      1 2 3 4 5 6 7
    "
  end

  def update_board(player)
    column_number = gets_move
    @columns[column_number].push(player.symbol)
  end

  def gets_move
    puts 'Please select a column'
    column = gets.chomp
    until valid_column?(column)
      puts 'Invalid column'
      column = gets.chomp
    end
    while full_column?(column)
      puts 'Column full'
      column = gets.chomp
    end
    column
  end

  def valid_column?(column)
    input = column.to_i
    return true if input.positive? && input < 8

    false
  end

  def full_column?(column)
    return true if @columns[column].length >= 6

    false
  end
end
