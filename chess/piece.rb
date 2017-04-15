class Piece
  attr_reader :symbol, :position, :color
  attr_accessor :board

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
    @symbol = "p"
  end

  def valid_moves

  end

  def empty?

  end

  private

  def move_into_check?(end_pos)
    duped = board.board_dup
    duped.move_piece(@position, end_pos)
    duped.in_check?(@color)
  end
end
