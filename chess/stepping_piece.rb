module SteppingPiece
  def moves
    new_positions = move_diffs.map do |move|
      [position[0] + move[0], position[1] + move[1]]
    end
    new_positions.select do |pos|
      board.in_bounds?(pos) && board[pos].color != color
    end
  end

  private
  def move_diffs
    if self.is_a?(Knight)
      [[2,-1],[2,1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
    elsif self.is_a?(King)
      [[0,1],[0,-1],[1,0],[-1,0],[-1,1],[1,1],[1,-1],[-1,-1]]
    end
  end

end
