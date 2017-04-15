class Hand
  RANKS = {
    high_card: 0,
    pair: 100,
    two_pair: 200,
    triple: 300,
    straight: 400,
    flush: 500,
    full_house: 600,
    four_kind: 700,
    straight_flush: 800,
    royal_flush: 900
  }

  VALUES = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]

  attr_reader :cards, :deck, :rank

  def initialize(deck)
    @cards = []
    @deck = deck
    @rank = 0
  end

  def draw_cards
    5.times { @cards << @deck.cards.pop }
    determine_rank
    same_rank_comparison
    @cards
  end

  def determine_rank
    if flush? && find_card_values.sort == ["10", "A", "J", "K", "Q"]
      @rank = RANKS[:royal_flush]
    elsif flush? && straight?
      @rank = RANKS[:straight_flush]
    elsif four_kind?
      @rank = RANKS[:four_kind]
    elsif full_house?
      @rank = RANKS[:full_house]
    elsif flush?
      @rank = RANKS[:flush]
    elsif straight?
      @rank = RANKS[:straight]
    elsif triple?
      @rank = RANKS[:triple]
    elsif two_pair?
      @rank = RANKS[:two_pair]
    elsif pair?
      @rank = RANKS[:pair]
    else
      @rank = RANKS[:high_card]
      idx = @cards.sort_by {|card| VALUES.index(card.value)}.last.value
      @rank += VALUES.index(idx)
    end
    @rank
  end

  private
  def same_rank_comparison

  end

  def flush?
    find_card_suits.uniq.count == 1
  end

  def straight?
    straight_subsets.include?(find_card_values.sort)
  end

  def four_kind?
    # ["A" "A" "A" "A" "2"]
    count = Hash.new(0)
    @cards.each { |card| count[card] += 1 }
    count.select { |k,v| v == 4}.count == 1
  end

  def full_house?
    find_card_values.uniq.count == 2
  end

  def triple?
    count = Hash.new(0)
    @cards.each { |card| count[card] += 1 }
    count.select { |k,v| v == 3}.count == 1
  end

  def two_pair?
    find_card_values.uniq.count == 3
  end

  def pair?
    count = Hash.new(0)
    @cards.each { |card| count[card] += 1 }
    count.select { |k,v| v == 2}.count == 1
  end

  def find_card_values
    cards.map {|card| card.value}
  end

  def find_card_suits
    cards.map {|card| card.suit}
  end

  def straight_subsets
    card_subsets = []
    (0...VALUES.length).each do |idx1|
      (idx1 + 1...VALUES.length).each do |idx2|
        sub_set = VALUES[idx1..idx2]
        card_subsets << sub_set if sub_set.length == 5
      end
    end
    (card_subsets.uniq + [["A", "2", "3", "4", "5"]]).map(&:sort)
  end

end
