# frozen_string_literal: true

require_relative 'deal_cards'
class DealDeck
  include DealCards
  attr_reader :cards
  attr_accessor :deck

  def initialize
    @cards = DealCards.cards
    @deck = reset_deck
  end

  def reset_deck
    self.deck = cards.keys
  end

  def draw_card
    card_drawn = deck.sample
    card = cards[card_drawn]
    deck.delete(card_drawn)
    reset_deck if deck.empty?
    card
  end
end
# deal_pile = DealDeck.new
# 18.times { puts deal_pile.draw_card }
