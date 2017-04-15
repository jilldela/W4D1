require_relative 'stepping_piece'

class King < Piece
  include SteppingPiece
  
  def initialize(position, board, color)
    super
    @symbol = "K"
  end

end
