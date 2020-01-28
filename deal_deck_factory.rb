require_relative 'deal_deck'
require_relative 'deal_cards'
require_relative 'builder'

module DealDeckFactory
  include Builder
  extend self

  def create(type)
    case type
    when default
      cards = DealCards.for(default)
      DealDeck.new(cards: cards, deck: cards.keys)
    when custom
      cards = DealCards.for(custom)
      DealDeck.new(cards: cards, deck: cards.keys)
    when random
      cards = DealCards.for(random)
      DealDeck.new(cards: cards, deck: cards.keys)
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

end