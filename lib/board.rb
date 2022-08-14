require 'os'

# Board class
class Board
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
    BOARD_HEIGHT.times do |row|
      BOARD_WIDTH.times do |column|
        if check_vertical(row, column,
                          piece) || check_horizontal(row, column, piece) || check_diagonals(row, column, piece)
          true
        end
      end
    end
    false
  end

  def check_vertical(row, column, piece)
    return if row > 2

    @grid[row][column] == piece && @grid[row + 1][column] == piece && @grid[row + 2][column] == piece && @grid[row + 3][column] == piece
  end

  def check_horizontal(row, column, piece)
    return if column > 3

    @grid[row][column] == piece && @grid[row][column + 1] == piece && @grid[row][column + 2] == piece && @grid[row][column + 3] == piece
  end

  def check_diagonals(row, column, piece)
    return unless row < 3

    check_right_diagonal(row, column, piece) || check_left_diagonal(row, column, piece)
  end

  def check_left_diagonal(row, column, piece)
    return if column > 3

    @grid[row][column] == piece && @grid[row + 1][column + 1] == piece && @grid[row + 2][column + 2] == piece && @grid[row + 3][column + 3] == piece
  end

  def check_right_diagonal(row, column, piece)
    return if column < 3

    @grid[row][column] == piece && @grid[row + 1][column - 1] == piece && @grid[row + 2][column - 2] == piece && @grid[row + 3][column - 3] == piece
  end
end
