# string-frozen-literal: true

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
      '1': [],
      '2': [],
      '3': [],
      '4': [],
      '5': [],
      '6': [],
      '7': []
    }
  end

  def gets_move
    puts 'Please select input column'
    column = gets.chomp until valid_column?
  end

  def valid_column?(column)
    input = column.to_i
    return true if input > 0 && input < 8

    false
  end

  def full_column?(column)
    return true if @columns[column].length >= 6

    false
  end
end
