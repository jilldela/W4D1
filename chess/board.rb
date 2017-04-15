require_relative 'piece'
require_relative 'nullpiece'
require_relative 'queen'
require_relative 'rook'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def move_piece(start_pos, end_pos)
    # raise ArgumentError unless valid_move?(start_pos, end_pos)
    self[start_pos],self[end_pos] = self[end_pos],self[start_pos]
    @grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, target)
    x, y = pos
    @grid[x][y] = target
  end

  def in_bounds?(pos)
    pos.all? { |el| el >= 0 && el <= 7 }
  end

  def checkmate?(color)
    # king is currently in check and all valid moves by
    # the king's color pieces leaves king in check
    in_check?(color)

  end

  def board_dup
    new_board = Board.new
    0.upto(7).each do |row|
      0.upto(7).each do |col|
        if self[[row,col]].is_a?(NullPiece)
          new_board[[row,col]] = NullPiece.instance
        else
          new_board[[row,col]] = self[[row,col]].dup
          new_board[[row,col]].board = new_board
        end
      end
    end
    new_board
  end

  def in_check?(color)
    moves = []
    king_pos = nil
    0.upto(7).each do |row|
      0.upto(7).each do |col|
        piece = self[[row,col]]
        moves += piece.moves unless piece.color == color
      end
    end
    moves.include?(king_pos(color)) ? true : false
  end

  def king_pos(color)
    0.upto(7).each do |row|
      0.upto(7).each do |col|
        piece = self[[row,col]]
        return [row,col] if piece.is_a?(King) && piece.color == color
      end
    end
  end


def populate_board
  0.upto(7).each do |row|
    0.upto(7).each do |col|
      case row
      when 1
        self[[row,col]] = Pawn.new([row,col], self, :red)
      when 6
        self[[row,col]] = Pawn.new([row,col], self, :blue)
      when 0
        case col
        when 0
          self[[row,col]] = Rook.new([row,col], self, :red)
        when 7
          self[[row,col]] = Rook.new([row,col], self, :red)
        when 1
          self[[row,col]] = Knight.new([row,col], self, :red)
        when 6
          self[[row,col]] = Knight.new([row,col], self, :red)
        when 2
          self[[row,col]] = Bishop.new([row,col], self, :red)
        when 5
          self[[row,col]] = Bishop.new([row,col], self, :red)
        when 3
          self[[row,col]] = King.new([row,col], self, :red)
        when 4
          self[[row,col]] = Queen.new([row,col], self, :red)
          # self[[row,col]] = Queen.new([row,col], self, :red)
        end
      when 7
        case col
        when 0
          self[[row,col]] = Rook.new([row,col], self, :blue)
        when 7
          self[[row,col]] = Rook.new([row,col], self, :blue)
        when 1
          self[[row,col]] = Knight.new([row,col], self, :blue)
        when 6
          self[[row,col]] = Knight.new([row,col], self, :blue)
        when 2
          self[[row,col]] = Bishop.new([row,col], self, :blue)
        when 5
          self[[row,col]] = Bishop.new([row,col], self, :blue)
        when 3
          self[[row,col]] = King.new([row,col], self, :blue)
        when 4
          self[[row,col]] = Queen.new([row,col], self, :blue)
        end
      else
        self[[row,col]] = NullPiece.instance
      end
    end
  end
end

  private
  # def valid_move?(start_pos, end_pos)
  #   in_bounds?(end_pos) &&
  #   self[end_pos].nil? && self[start_pos]
  # end

end
