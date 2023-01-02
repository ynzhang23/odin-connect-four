# string-frozen-literal: true

# Handles player creation with player name and piece
class Player
  attr_reader :name, :symbol

  def initialize
    @name = nil
    @symbol = nil
  end

  def gets_name
    name_question
    @name = gets.chomp
  end

  def gets_symbol
    symbol_question
    choice = gets.chomp until valid_symbol?(choice)
    choice
  end

  def update_symbol
    @symbol = '☻' if gets_symbol == '1'
    @symbol = '☺' if gets_symbol == '2'
  end

  def valid_symbol?(choice)
    return true if choice == '1' || choice == '2'
    false
  end

  def symbol_question
    puts 'Please choose your symbol:
    1: ☻
    2: ☺'
  end

  def name_question
    puts 'Please enter your name: '
  end
end