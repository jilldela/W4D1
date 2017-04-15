require_relative 'tile'

class Board
  def initialize(num_bombs)
    @grid = Array.new(9) { Array.new(9) }
    populate_grid(num_bombs)
  end

  def populate_grid(num_bombs)
    # populate with bombs
    bomb_count = 0
    until bomb_count == num_bombs
      if self[random_pos].nil?
        self[random_pos] = Tile.new(true)
        bomb_count += 1
      end
    end
    # populate with empty tiles
    @grid.each_with_index do |row,row_i|
      row.each_with_index do |tile,col_i|
        self[[row_i,col_i]] = Tile.new(false) if tile.nil?
      end
    end
    label_bomb_counts
  end

  def random_pos
    [rand(9),rand(9)]
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @grid[x][y] = value
  end

  def won?
    @grid.flatten.all? { |tile| tile.revealed }
  end

  def render
    print " "
    9.times { |n| print "#{n} " }
    puts
    @grid.each_with_index do |row, i|
      print i
      row.each do |tile|
        print "#{tile} "
      end
      puts
    end
  end

  # called only when game ends
  def render_all
    @grid.each do |row|
      row.each do |tile|
        print (tile.bomb ? "B " : "#{tile} ")
      end
      puts
    end
  end

  def label_bomb_counts
    9.times do |row_i|
      9.times do |col_i|
        label_bomb_count([row_i,col_i])
      end
    end
  end

  # stores in Tile how many neighboring bombs are present
  def label_bomb_count(pos)
    tile = self[pos]
    tile.adjacent_count = adjacent_bomb_count(pos)
  end

  def adjacent_bomb_count(pos)
    row, col = pos
    count = 0
    adjacent_positions(pos).each do |neighbor_pos|
      count += 1  if self[neighbor_pos].bomb
    end
    count
  end

  def adjacent_positions(pos)
    row, col = pos
    positions = [[row+1,col], [row-1,col], [row,col+1], [row,col-1],
      [row+1,col+1], [row+1,col-1], [row-1,col-1], [row-1,col+1]]
    positions.reject do |adj_pos|
      adj_pos.any? {|el| el < 0 || el > 8}
    end
  end

  #reveal tile, return true if bomb and false if not
  def reveal(pos)
    return true if self[pos].bomb
    self[pos].revealed=true
    if self[pos].adjacent_count == 0
      adjacents = adjacent_positions(pos).reject do |adjacent|
        self[adjacent].revealed
      end
      adjacents.each {|adj_pos| reveal(adj_pos)}
    end
    false
  end

  def place_flag(pos)
    self[pos].flagged = !self[pos].flagged
  end
end
