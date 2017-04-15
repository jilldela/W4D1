require_relative 'sliding_piece'

class Rook < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
    @symbol = "R"
  end

end
