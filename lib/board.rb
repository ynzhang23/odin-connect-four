# frozen-string-literal: true

# Handles board creation with player positions, move 
# verification and winning-condition
class Board
  attr_accessor :columns, :last_move_column, :last_move_row

  def initialize
    @columns = create_board
    @last_move_column = nil
    @last_move_row = nil
  end

  def create_board
    {
      1 => [],
      2 => [],
      3 => [],
      4 => [],
      5 => [],
      6 => [],
      7 => []
    }
  end

  def print_board
    one = @columns[1]
    two = @columns[2]
    three = @columns[3]
    four = @columns[4]
    five = @columns[5]
    six = @columns[6]
    seven = @columns[7]

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
    puts "#{player.name}, please select a column"
    column_number = gets_move
    @columns[column_number].push(player.symbol)
  end

  def gets_move
    column = gets.chomp
    until valid_column?(column)
      puts 'Invalid column'
      column = gets.chomp
    end
    while full_column?(column)
      puts 'Column full'
      column = gets.chomp
    end
    @last_move_column = column.to_i
    @last_move_row = @columns[column.to_i].length
    column.to_i
  end

  def valid_column?(column)
    input = column.to_i
    return true if input.positive? && input < 8

    false
  end

  def full_column?(column)
    return true if @columns[column.to_i].length >= 6

    false
  end

  def matching_adjacent_piece(player)
    adjacent_match = []
    symbol = player.symbol
    adjacent_match.push('top') if symbol == adjacent_top(@last_move_column, @last_move_row)
    adjacent_match.push('bottom') if symbol == adjacent_bottom(@last_move_column, @last_move_row)
    adjacent_match.push('left') if symbol == adjacent_left(@last_move_column, @last_move_row)
    adjacent_match.push('right') if symbol == adjacent_right(@last_move_column, @last_move_row)
    adjacent_match.push('top_left') if symbol == adjacent_top_left(@last_move_column, @last_move_row)
    adjacent_match.push('top_right') if symbol == adjacent_top_right(@last_move_column, @last_move_row)
    adjacent_match.push('bottom_left') if symbol == adjacent_bottom_left(@last_move_column, @last_move_row)
    adjacent_match.push('bottom_right') if symbol == adjacent_bottom_right(@last_move_column, @last_move_row)

    adjacent_match
  end

  def adjacent_top(column, row)
    return 'out of bound' if (row + 1) > 5

    @columns[column][row + 1]
  end

  def adjacent_bottom(column, row)
    return 'out of bound' if (row - 1).negative?

    @columns[column][row - 1]
  end

  def adjacent_left(column, row)
    return 'out of bound' if (column - 1) < 1

    @columns[column - 1][row]
  end

  def adjacent_right(column, row)
    return 'out of bound' if (column + 1) > 7

    @columns[column + 1][row]
  end

  def adjacent_top_left(column, row)
    return 'out of bound' if (column - 1) < 1 || (row + 1) > 5

    @columns[column - 1][row + 1]
  end

  def adjacent_top_right(column, row)
    return 'out of bound' if (column + 1) > 7 || (row + 1) > 5

    @columns[column + 1][row + 1]
  end

  def adjacent_bottom_left(column, row)
    return 'out of bound' if (column - 1) < 1 || (row - 1).negative?

    @columns[column - 1][row - 1]
  end

  def adjacent_bottom_right(column, row)
    return 'out of bound' if (column + 1) > 7 || (row - 1).negative?

    @columns[column + 1][row - 1]
  end

  def winning_move?(player)
    column = @last_move_column
    symbol = player.symbol
    row = @last_move_row
    direction_array = matching_adjacent_piece(player)
    direction_array.each do |direction|
      if direction == 'top'
        return true if top_win?(symbol, column, row)
      end
      if direction == 'bottom'
        return true if bottom_win?(symbol, column, row)
      end
      if direction == 'left'
        return true if left_win?(symbol, column, row)
      end
      if direction == 'right'
        return true if right_win?(symbol, column, row)
      end
      if direction == 'top_left'
        return true if top_left_win?(symbol, column, row)
      end
      if direction == 'top_right'
        return true if top_right_win?(symbol, column, row)
      end
      if direction == 'bottom_left'
        return true if bottom_left_win?(symbol, column, row)
      end
      if direction == 'bottom_right'
        return true if bottom_right_win?(symbol, column, row)
      end
    end
    false
  end

  def top_win?(symbol, column, row)
    return false if (row + 3) > 5
    3.times do
      row += 1
      return false unless @columns[column][row] == symbol
    end
    true
  end

  def bottom_win?(symbol, column, row)
    return false if (row - 3).negative?

    3.times do
      row -= 1
      return false unless @columns[column][row] == symbol
    end
    true
  end

  def left_win?(symbol, column, row)
    return false if (column - 3) > 1
    3.times do
      column -= 1
      return false unless @columns[column][row] == symbol
    end
    true
  end

  def right_win?(symbol, column, row)
    return false if (column + 3) > 7
    3.times do
      column += 1
      return false unless @columns[column][row] == symbol
    end
    true
  end

  def top_left_win?(symbol, column, row)
    return false if (column - 3) < 1 || (row + 3) > 5
    3.times do
      row += 1
      column -= 1
      return false unless @columns[column][row] == symbol
    end
    true
  end

  def top_right_win?(symbol, column, row)
    return false if (column + 1) > 7 || (row + 1) > 5
    3.times do
      column += 1
      row += 1
      return false unless @columns[column][row] == symbol
    end
    true
  end

  def bottom_left_win?(symbol, column, row)
    return false if (column - 3) < 1 || (row - 3).negative?
    3.times do
      row -= 1
      column -= 1
      return false unless @columns[column][row] == symbol
    end
    true
  end

  def bottom_right_win?(symbol, column, row)
    return false if (column + 1) > 7 || (row - 1).negative?
    3.times do
      column += 1
      row -= 1
      return false unless @columns[column][row] == symbol
    end
    true
  end
end
