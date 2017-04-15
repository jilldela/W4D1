require_relative 'board'
require 'time'

class Minesweeper
  def initialize(board = Board.new(10))
    @board = board
  end

  def play
    puts "Welcome to Minesweeper"
    lose = false

    until lose
      system("clear")
      @board.render
      pos = get_pos
      if get_flag == "f"
        @board.place_flag(pos)
      else
        lose = @board.reveal(pos) unless @board[pos].flagged
        break if @board.won?
      end
    end
    system("clear")
    @board.render_all
    puts (lose ? "You lose" : "You win!")
  end

  def get_pos
    print "Enter your position (x,y): "
    result = gets.chomp.split(",").map(&:to_i)
    until result.all? {|n| n >= 0 && n <= 8}
      print "Not a valid entry, try again: "
      result = gets.chomp.split(",").map(&:to_i)
    end
    result
  end

  def get_flag
    print "Enter 'f' to FLAG or any other key to REVEAL: "
    gets.chomp
  end
end

if __FILE__ == $PROGRAM_NAME
  print "Enter number of bombs desired: "
  bomb_count = gets.chomp.to_i
  board = Board.new(bomb_count)
  game = Minesweeper.new(board)

  t = Time.now
  game.play
  elapsed = Time.now - t
  puts "You took #{elapsed} seconds this game!"
end
