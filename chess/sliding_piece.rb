module SlidingPiece
  def moves
    total_moves = []
    move_dirs.each do |dir|
      total_moves += grow_unblocked_moves_in_dir(dir[0],dir[1])
    end
    total_moves
  end

  def move_dirs
    if self.is_a?(Rook)
      horizontal_dirs
    elsif self.is_a?(Bishop)
      diagonal_dirs
    elsif self.is_a?(Queen)
      horizontal_dirs + diagonal_dirs
    end
  end

  def horizontal_dirs
    [[0,1],[0,-1],[1,0],[-1,0]]
  end

  def diagonal_dirs
    [[-1,1],[1,1],[1,-1],[-1,-1]]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    x, y = dx, dy
    mag = 1
    unblocked_moves = []
    while true
      new_pos = [position[0] + mag * x, position[1] +  mag * y]
      if !board.in_bounds?(new_pos) || board[new_pos].color == color
        break
      elsif board[new_pos].is_a?(NullPiece)
        unblocked_moves << new_pos
      else
        unblocked_moves << new_pos
        break
      end
      mag += 1
    end
    unblocked_moves
  end

end
