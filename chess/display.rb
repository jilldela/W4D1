require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    puts "  0 1 2 3 4 5 6 7"
    board.grid.each_with_index do |row,row_idx|
      print "#{row_idx} "
      row.each_index do |col_idx|
        piece = board[[row_idx, col_idx]]
        print_str = piece.symbol.colorize(piece.color)

        if @cursor.cursor_pos == [row_idx, col_idx]
          print_str = print_str.colorize(:color => :light_blue, :background => :yellow).blink
        end
        print print_str + " "
      end
      puts
    end

  end

end

b = Board.new
b.populate_board
b2 = b.board_dup
d = Display.new(b)
system("clear")
d.render
while true
  d.cursor.get_input
  system("clear")
  d.render
end
