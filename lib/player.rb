# frozen-string-literal: true

# Handles player creation with player name and piece
class Player
  attr_reader :name
  attr_accessor :symbol

  def initialize(name = nil, symbol = nil)
    @name = name
    @symbol = symbol
  end

  def gets_name
    @name = gets.chomp
  end

  def update_symbol
    choice = gets_symbol
    @symbol = '☻' if choice == '1'
    @symbol = '☺' if choice == '2'
  end

  def gets_symbol
    symbol_question
    choice = gets.chomp
    until valid_symbol?(choice) do
      puts 'Input error!'
      choice = gets.chomp
    end
    choice
  end

  def valid_symbol?(choice)
    return true if choice == '1' || choice == '2'
    false
  end

  def symbol_question
    puts '
    Please choose your symbol:
    1: ☻
    2: ☺'
  end

  def name_question_player_one
    puts '
    Player 1, please enter your name: '
  end

  def name_question_player_two
    puts '
    Player 2, please enter your name: '
  end
end
