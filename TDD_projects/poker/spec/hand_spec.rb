require 'rspec'
require 'hand'
require 'card'

describe Hand do
  let(:deck) { double("deck", cards:
    [double("card1", value: "3", suit: "spades"),
    double("card2", value: "4", suit: "hearts"),
    double("card3", value: "5", suit: "hearts"),
    double("card4", value: "7", suit: "diamonds"),
    double("card5", value: "J", suit: "hearts")])}

  subject(:hand) { Hand.new(deck) }
  # Hand has a reference to a deck
  describe '#initialize' do
    it 'starts cards as an empty array' do
      expect(hand.cards).to be_empty
    end
    it 'saves a deck' do
      expect(hand.deck).to eq(deck)
    end
    it 'sets default rank to 0' do
      expect(hand.rank).to eq(0)
    end
  end

  describe '#draw_cards' do
    it 'returns an array of 5 cards' do
      expect(hand.draw_cards.count).to eq(5)
    end
  end

  describe '#determine_rank' do
    it 'increments the rank variable' do
      hand.draw_cards
      expect(hand.determine_rank).to eq(9)
    end
  end
end
