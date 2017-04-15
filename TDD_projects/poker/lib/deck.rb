require_relative 'card'

class Deck
  VALUES = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
  SUITS = ["spades","hearts","diamonds","clubs"]

  attr_reader :cards

  def initialize
    @cards = []
    populate_cards
  end

  def shuffle
    @cards.shuffle
  end

  private
  def populate_cards
    VALUES.each do |value|
      SUITS.each do |suit|
        @cards << Card.new(value,suit)
      end
    end
  end
end
