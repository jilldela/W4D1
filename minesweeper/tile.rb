class Tile
  attr_accessor :revealed, :flagged, :adjacent_count
  attr_reader :bomb

  def initialize(bomb = false)
    @bomb = bomb
    @revealed = (bomb ? true : false)
    @flagged = false
    @adjacent_count = nil
  end

  def to_s
    return "F" if flagged
    return "*" if bomb
    return "*" unless revealed
    adjacent_count == 0 ? "_" : adjacent_count.to_s
  end
end
