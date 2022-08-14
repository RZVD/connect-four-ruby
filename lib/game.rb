# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Game class
class Game
  EMPTY_CIRCLE = "\u25cb"
  YELLOW_CIRCLE = "\e[33m\u25cf\e[0m"
  BLUE_CIRCLE = "\e[34m\u25cf\e[0m"

  def initialize
    @ended = false
    @board = Board.new
    @player1 = Player.new(ask_name(1), YELLOW_CIRCLE)
    @player2 = Player.new(ask_name(2), BLUE_CIRCLE)
    @players = [@player1, @player2]
    @current = 0
    @board.draw
  end

  def play
    until @board.full? || @ended
      turn
      @board.draw
      if @board.won?(@players[@current].piece)
        puts "#{@players[@current].name} won!"
        exit
      end
      change_player_turn

    end
    exit
  end

  def ended?
    @ended
  end

  private

  def ask_name(number)
    puts "Player#{number}'s name:"
    gets.chomp
  end

  def turn
    column = gets.chomp.to_i - 1
    @board.place_move(@players[@current].piece, column)
  end

  def change_player_turn
    @current = (@current + 1) % 2
  end
end
