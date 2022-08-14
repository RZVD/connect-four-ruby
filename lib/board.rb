require 'os'

# Board class
class Board
  EMPTY_CIRCLE = "\u25cb"
  YELLOW_CIRCLE = "\e[33m\u25cf\e[0m"
  BLUE_CIRCLE = "\e[34m\u25cf\e[0m"

  attr_reader :grid

  BOARD_HEIGHT = 6
  BOARD_WIDTH = 7
  def initialize
    @grid = Array.new(BOARD_HEIGHT) { Array.new(BOARD_WIDTH, "\u25cb") }
    @stack_top = Array.new(BOARD_WIDTH, BOARD_HEIGHT - 1)
  end

  def full?
    @grid.flatten.none? { |piece| piece == "\u25cb" }
  end

  def place_move(piece, column)
    @grid[@stack_top[column]][column] = piece
    @stack_top[column] -= 1
  end

  def draw
    OS.linux? ? system('clear') : system('cls')

    grid.each do |row|
      puts row.join(' ')
    end
    puts (1..7).to_a.join(' ')
  end

  def won?(piece)
    horizontal_check(piece) || vertical_check(piece) || diagonal_check(piece)
  end

  def horizontal_check(piece)
    @grid.each do |row|
      # window = row.each_cons(4).uniq
      row.each_cons(4) do |window|
        return true if window.all? { |slot| slot == piece }
      end
    end
    false
  end

  def vertical_check(piece)
    @grid.transpose.each do |row|
      # window = row.each_cons(4).uniq
      row.each_cons(4) do |window|
        return true if window.all? { |slot| slot == piece }
      end
    end
    false
  end

  def diagonal_check(_piece)
    false
  end
end
