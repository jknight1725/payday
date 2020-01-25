require_relative 'deal_deck'
require_relative 'deal_card_factory'
module DealDeckFactory
  extend self

  def create(type)
    case type
    when 'default'
      DealDeck.new
    when 'custom'
      cards = DealCardFactory::create_deal_cards
      cards ? DealDeck.new(cards:cards, deck: cards.keys) : DealDeck.new
    end
  end

end