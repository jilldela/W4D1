require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece

  def initialize(position, board, color)
    super
    @symbol = "∑"
  end

end
