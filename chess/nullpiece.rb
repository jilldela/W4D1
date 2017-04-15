require 'singleton'

class NullPiece < Piece
  include Singleton

  attr_reader :color, :symbol

  def initialize
    @symbol = "_"
    @color = :black
  end

  def moves
    []
  end
end
