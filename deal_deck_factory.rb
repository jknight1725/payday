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
      deal_deck = DealDeck.new(cards: cards, deck: cards.keys)
      save? deal_deck
    when random
      cards = DealCards.for(random)
      DealDeck.new(cards: cards, deck: cards.keys)
    when from_file
      deal_deck = DealCards.for(from_file)
      DealDeck.new(cards: deal_deck[:cards], deck: deal_deck[:deck])
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

  def save?(data)
    #puts "Press 1 to save this deck, any other key to continue"
    FileManager.command('save', 'deal deck', data.to_h)
  end

end
