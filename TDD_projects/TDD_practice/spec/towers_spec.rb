require 'rspec'
require 'towers'
require 'byebug'

describe TowersOfHanoi do
  subject(:towers) {TowersOfHanoi.new}

  describe '#initialize' do
    it 'sets the discs variable as an array of length 3' do
      expect(towers.discs.count).to eq(3)
    end

    it 'contains 3 discs in the first element' do
      expect(towers.discs[0].count).to eq(3)
    end
  end

  describe '#move' do
    it 'raises an error if start position is empty' do
      expect { towers.move(1,0) }.to raise_error('Invalid move')
    end

    it 'raises an error if disc size is larger than lower disc' do
      towers.move(0,1)
      expect { towers.move(0,1) }.to raise_error('Invalid move')
    end
    context 'move is valid' do
      it 'takes one disc from starting tower' do
        towers.move(0,1)
        expect(towers.discs[0]).to eq([3,2])
      end

      it 'places disc at destination tower' do
        towers.move(0,1)
        expect(towers.discs[1]).to eq([1])
      end
    end
  end

  describe '#won?' do
    it 'checks to see if first tower is empty' do
      expect(towers.won?).to be false
    end

    it 'checks to see if two towers are empty' do
      towers.move(0,1)
      expect(towers.won?).to be false
    end
  end
end
