require_relative 'deal_cards'
module DealCardFactory
  include DealCards
  extend self

  def create_deal_cards(deck_size)
    cards={}
    deck_size < 1 ? cards = DealCards.cards : deck_size.times { get_deals cards }
    cards
  end

  def get_deals(cards)
    puts "Enter the name of the deal"
    name = gets.chomp
    puts "Enter the cost"
    cost = gets.to_i
    puts "Enter the value"
    value = gets.to_i
    puts "Enter the commission"
    commission = gets.to_i
    cards[name.to_sym] = DealCards::Card.new(name:name, cost:cost, value:value, commission: commission)
  end

end