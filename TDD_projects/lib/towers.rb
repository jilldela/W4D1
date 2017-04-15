class TowersOfHanoi
  attr_accessor :discs
  def initialize
    @discs = [[3,2,1],[],[]]
  end

  def play
    until won?
      p @discs
      start_pos = gets.chomp.to_i
      end_pos = gets.chomp.to_i
      move(start_pos, end_pos)
    end
    p @discs
    puts "You win!"
  end

  def move(start_pos, end_pos)
    first = @discs[start_pos]
    second = @discs[end_pos]

    if first.empty?
      raise "Invalid move"
    elsif second.empty? || first.last < second.last
      second << first.pop
    else
      raise "Invalid move"
    end
  end

  def won?
    @discs[0].empty? && @discs.count([]) == 2
  end
end

if __FILE__ == $PROGAM_NAME
  towers = TowersOfHanoi.new
  towers.play
end
