require_relative 'deal_deck'
require_relative 'deal_cards'
module DealCardFactory
  extend self

  def create_deal_cards
    amount = deck_size
    cards={}
    if amount <= 0
      cards = nil
    else
      amount.times { get_deals cards }
    end
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

  def deck_size
    puts "How many custom deal cards?"
    gets.to_i
  end
end