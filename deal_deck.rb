# frozen_string_literal: true
class DealDeck
  attr_accessor :cards, :deck

  def initialize(args={})
    @cards = args[:cards]
    @deck = args[:deck]
  end

  def to_h
    {
      cards: self.cards.map{|k,v| [k.to_i, v.to_h]}.to_h,
      deck: deck
    }
  end

  def reset_deck
    self.deck = cards.keys
  end

  def draw_card
    reset_deck if deck.empty?
    card_drawn = deck.sample
    self.deck.delete(card_drawn)
    cards[card_drawn]
  end

end
