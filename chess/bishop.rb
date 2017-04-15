require_relative 'sliding_piece'

class Bishop < Piece
  include SlidingPiece
  
  def initialize(position, board, color)
    super
    @symbol = "B"
  end

end
