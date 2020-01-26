require_relative 'deal_deck'
require_relative 'deal_card_factory'
require_relative 'builder'
module DealDeckFactory
  include Builder
  extend self

  def create(type)
    case type
    when default
      DealDeck.new
    when custom
      cards = DealCardFactory.create_deal_cards(deck_size)
      DealDeck.new(cards:cards, deck: cards.keys)
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

  def deck_size
    puts "How many custom deal cards?"
    gets.to_i
  end
end