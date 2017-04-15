class Array
  def my_uniq
    uniques = []
    self.each do |el|
      uniques << el unless uniques.include?(el)
    end
    uniques
  end

  def two_sum
    result = []
    (0...length).each do |idx1|
      (0...length).each do |idx2|
        next if idx1 == idx2
        if self[idx1] + self[idx2] == 0
          result << [idx1,idx2] unless result.include?([idx2,idx1])
        end
      end
    end
    result
  end

  def my_transpose
    dimension = self.length
    columns = Array.new(dimension){Array.new(dimension)}

    dimension.times do |x|
      dimension.times do |y|
        columns[x][y] = self[y][x]
      end
    end
    columns
  end
end

def stock_picker(prices)
  record = 0
  day_indices = [0, 1]
  (0...prices.length).each do |idx1|
    (idx1 + 1...prices.length).each do |idx2|
      if prices[idx2] - prices[idx1] > record
        record = prices[idx2] - prices[idx1]
        day_indices = [idx1, idx2]
      end
    end
  end
  day_indices
end
