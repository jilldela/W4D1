class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value)
    @value, @parent, @children = value, nil, []
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    if node && !node.children.include?(self)
      node.children << self
    end
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end

  def remove_child(child_node)
    deleted = @children.delete(child_node)
    raise "not a child" unless deleted
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      child_search = child.dfs(target_value)
      return child_search if child_search
    end
    nil
  end

  def bfs(target_value)
    current_search = [self]
    until current_search.empty?
      if current_search.first.value == target_value
        return current_search.first
      else
        first_children = current_search.first.children
        current_search += first_children
        current_search.shift
      end
    end
    nil
  end
end
