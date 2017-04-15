require 'first_tdd'
require 'rspec'

describe Array do
  subject(:nums) { [1, 2, 1, 3, 3] }
  let(:uniq_nums) { [1,2,3] }

  describe '#my_uniq' do
    it 'returns an array' do
      expect(nums.my_uniq).to be_an Array
    end
    it 'removes duplicates' do
      expect(nums.my_uniq).to eq(nums.uniq)
    end
    it 'does not mutate the original array' do
      dup_nums = nums.dup
      dup_nums.my_uniq
      expect(dup_nums).to eq(nums)
    end
    it 'returns the same elements if all numbers are unique' do
      expect(nums.my_uniq).to eq(uniq_nums)
    end
  end

  let(:two_sum_nums) { [-1, 0, 2, -2, 1] }

  describe '#two_sum' do
    let(:result) { two_sum_nums.two_sum }
    it 'returns an array' do
      expect(result).to be_an Array
    end
    it 'returns an array of only two element sub-arrays' do
      expect(result.all? {|el| el.length == 2}).to be true
    end
    it 'sorts the pairs dictionary-wise' do
      expect(result).to eq(result.sort)
    end
    it 'sorts by smaller index before bigger index' do
      expect(result.all? {|el| el[0] < el[1]}).to be true
    end
    it 'does not have duplicates' do
      expect(result.uniq).to eq(result)
    end
    it 'returns all pairs that sum to zero' do
      expect(result).to eq([[0,4],[2,3]])
    end
  end

  let(:rows) { [[1,2,3],[4,5,6],[7,8,9]] }

  describe '#my_transpose' do
    it 'returns an array of arrays' do
      rows.my_transpose.each do |row|
        expect(row).to be_an(Array)
      end
    end
    it 'does not mutate the original array' do
      dup_rows = rows.dup
      dup_rows.my_transpose
      expect(dup_rows).to eq(rows)
    end
    it 'returns the same number of elements as original' do
      expect(rows.my_transpose.count).to eq(rows.count)
    end
    it 'returns the rows transposed into columns' do
      expect(rows.my_transpose).to eq([[1,4,7],[2,5,8],[3,6,9]])
    end
  end
end

describe '#stock_picker' do
  subject(:prices) {[200, 100, 500, 800, 300]}
  # let(:stock_result) {stock_picker(prices)}

  it 'takes in an array of prices' do
    expect { stock_picker(prices) }.to_not raise_error
  end
  it 'returns an array of length 2' do
    expect(stock_picker(prices).length).to eq(2)
  end
  it 'returns the correct pair of day indices' do
    expect(stock_picker(prices)).to eq([1, 3])
  end
end
