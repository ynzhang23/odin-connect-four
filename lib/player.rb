# string-frozen-literal: true

# Handles player creation with player name and piece
class Player
  attr_reader :name, :piece

  def initialize
    @name = gets_name
    @piece = nil
  end

  def gets_name
    puts 'Please enter your name: '
    @name = gets.chomp
  end
end
