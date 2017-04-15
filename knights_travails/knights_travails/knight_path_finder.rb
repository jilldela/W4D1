require_relative '00_tree_node'

class KnightPathFinder
  attr_accessor :start_node

  def initialize(pos)
    @visited_positions = [pos]
    @start_node = PolyTreeNode.new(pos)
  end

  def find_path(end_pos)
    build_move_tree
    last_node = @start_node.dfs(end_pos)
    # last_node = @start_node.bfs(end_pos)
    trace_path_back(last_node)
  end

  private
  def trace_path_back(end_node)
    path = [end_node]
    until path.first == @start_node
      path.unshift(path.first.parent)
    end
    path.map(&:value)
  end

  def self.valid_moves(pos)
    x,y = pos
    moves = [[x-1, y+2], [x+1, y+2], [x+2, y+1], [x+2, y-1],
    [x+1, y-2], [x-1, y-2], [x-2, y-1], [x-2, y+1]]
    moves.reject { |move| move.any? { |el| el < 0 || el > 7 }}
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos) - @visited_positions
    @visited_positions.concat(new_moves)
    new_moves
  end

  def build_move_tree
    process_queue = [@start_node]
    until process_queue.empty?
      children_moves = new_move_positions(process_queue.first.value)
      children_nodes = children_moves.map { |move| PolyTreeNode.new(move) }
      children_nodes.each do |node|
        process_queue.first.add_child(node)
      end
      process_queue += children_nodes
      process_queue.shift
    end
  end
end
