# frozen_string_literal: true
class DealDeck
  attr_reader :cards
  attr_accessor :deck

  def initialize(args={})
    @cards = args[:cards]
    @deck = args[:deck]
  end

  def to_h
    {
        cards: cards,
        deck: deck
    }
  end

  def reset_deck
    self.deck = cards.keys
  end

  def draw_card
    card_drawn = deck.sample
    self.deck.delete(card_drawn)
    reset_deck if deck.empty?
    cards[card_drawn]
  end

end
