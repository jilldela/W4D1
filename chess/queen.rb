require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPiece

  def initialize(position, board, color)
    super
    @symbol = "Q"
  end

end
