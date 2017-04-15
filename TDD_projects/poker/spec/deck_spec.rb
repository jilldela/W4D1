require 'rspec'
require 'deck'

describe Deck do
  subject (:deck) { Deck.new }

  describe '#initialize' do
    it 'has 52 cards' do
      expect(deck.cards.count).to eq(52)
    end
    it 'has 13 cards of each suit' do
      expect(deck.cards.count {|card| card.suit == "spades"}).to eq(13)
    end
    it 'has 4 cards of each value' do
      expect(deck.cards.count {|card| card.value == "5"}).to eq(4)
    end
  end

  describe '#shuffle' do
    it 'randomizes the deck' do
      expect(deck.shuffle).to_not eq(deck.cards)
    end
  end
end
