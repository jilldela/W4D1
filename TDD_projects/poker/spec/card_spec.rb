require 'rspec'
require 'card'

describe Card do
  subject(:card) {Card.new("10", "spades")}

  describe '#initialize' do
    it 'sets a value variable' do
      expect(card.value).to be_a String
    end
    it 'sets a suit variable' do
      expect(card.suit).to be_a String
    end
  end
end
