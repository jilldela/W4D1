class Pawn < Piece

  def moves
    moveset = forward_steps + side_attacks
  end

  def initialize(position, board, color)
    super
    @symbol = "Ω"
  end

  private
  def at_start_row?
    position.first == 1 && color == :red ||
    position.first == 6 && color == :blue
  end

  def forward_dir
    color == :red ? [1,0] : [-1,0]
  end

  def forward_steps
    dirs = []
    steps = (at_start_row? ? [1,2] : [1])
    steps.each do |step|
      dirs << forward_dir.map { |delta| step * delta }
    end
    # need to not skip over row 2 if something in the way
    second_row = board[[position[0]+steps[0]*forward_dir[0],position[1]]]
    dirs.pop unless second_row.is_a?(NullPiece)

    forward_moves = []
    dirs.each do |move|
      new_pos = [position[0]+move[0],position[1]+move[1]]
      if board.in_bounds?(new_pos) && board[new_pos].is_a?(NullPiece)

        forward_moves << new_pos
      end
    end
    forward_moves
  end

  def side_attacks
    diagonal_moves = []
    diagonal_dirs.each do |dir|
      new_pos = [position[0]+dir[0],position[1]+dir[1]]
      if board.in_bounds?(new_pos) && board[new_pos].color != color &&
        !board[new_pos].is_a?(NullPiece)
        diagonal_moves << new_pos
      end
    end
    diagonal_moves
  end

  def diagonal_dirs
    color == :red ? [[1,-1],[1,1]] : [[-1,-1],[-1,1]]
  end
end
