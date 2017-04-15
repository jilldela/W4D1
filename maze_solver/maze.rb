class Maze

  attr_reader :grid, :pathway

  def initialize(filename)
    @grid = File.readlines(filename).map do |line|
      line.chomp.chars
    end
    @pathway = File.readlines(filename).map do |line|
      line.chomp.chars
    end
    @ratings = []
  end

  def solve
    create_dist(start_location, grid, 0)
    trace_route
  end

  private

  def create_dist(location, grid, rating)
    moves = all_directions(location)
    moves.each do |move|
      if self[move] == "E"
        @ratings << rating
      elsif (self[move] == " ") ||
      (self[move].is_a?(Fixnum) && rating < self[move])
        grid[move[0]][move[1]] = rating
        create_dist(move, grid, rating + 1)
      end
    end
  end

  def trace_route # going backwards using distance markers
    current_dist = @ratings.min
    location = end_location

    while true
      moves = all_directions(location)
      if moves.none? {|move| self[move].is_a?(Fixnum)}
        puts "No path was found!"
        return
      end

      moves.each do |move|
        if self[move] == "S"
          create_file(pathway, "maze_sol.txt")
          return
        end
      end

      moves.each do |move|
        if (self[move] == current_dist - 1)
          pathway[move[0]][move[1]] = "X"
          current_dist -= 1
          location = move
        end
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def start_location
    grid.each.with_index do |row, i1|
      row.each_index do |i2|
        return [i1, i2] if self[[i1,i2]] == "S"
      end
    end
  end

  def end_location
    grid.each.with_index do |row, i1|
      row.each_index do |i2|
        return [i1, i2] if self[[i1,i2]] == "E"
      end
    end
  end

  def all_directions(location)
    [north(location),south(location),east(location),west(location)]
  end

  def north(location)
    [location[0]-1,location[1]]
  end

  def south(location)
    [location[0]+1,location[1]]
  end

  def east(location)
    [location[0],location[1]+1]
  end

  def west(location)
    [location[0],location[1]-1]
  end

  def create_file(solved_grid, filename)
    File.open(filename, 'w') do |file|
      file.puts solved_grid.map(&:join)
    end
    puts "Shortest path generated at \"#{filename}\""
  end
end

if $PROGRAM_NAME == __FILE__
  maze_solver = Maze.new(ARGV[0])

  maze_solver.solve
end
