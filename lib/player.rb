# player class
class Player
  attr_reader :piece, :name

  def initialize(name, piece)
    @name = name
    @piece = piece
  end
end
