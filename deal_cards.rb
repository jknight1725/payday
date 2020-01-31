# frozen_string_literal: true
require_relative 'builder'
require_relative 'file_manager'
module DealCards
  include Builder
  extend self

  def for(type)
    case type
    when default
      DefaultCards.arrangement
    when custom
      CustomCards.arrangement
    when random
      RandomCards.arrangement
    when from_file
      LoadedCards.arrangement
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end
  
  class Card
    attr_reader :name, :cost, :value, :commission
    def initialize(args={})
      min_100 = ->(x){ [100,x].max }
      min_10 = ->(x){ [10,x].max }
      args = defaults.merge args
      @name = args[:name]
      @cost = min_100[args[:cost]]
      @value = min_100[args[:value]]
      @commission = min_10[args[:commission]]
    end

    def defaults
      {
          name: 'Deal',
          cost: 100,
          value: 1000,
          commission: 10
      }
    end

    def to_h
      {
          name: name,
          cost: cost,
          value: value,
          commission: commission
      }
    end

    def to_s
      "#{name}\nCost:\t#{cost} Value:\t#{value} Commission:\t#{commission}\n"
    end
  end
  
  class CustomCards
    def self.arrangement
      custom_cards
    end
    
    def self.custom_cards
      cards={}
      amount = deck_size
      amount < 1 ? cards = DefaultCards.arrangement : (1..amount).each{|c| get_deals(c, cards) }
      cards
    end
    
    def self.get_deals(index, cards)
      puts "Enter the name of the deal"
      name = gets.chomp
      puts "Enter the cost"
      cost = gets.to_i
      puts "Enter the value"
      value = gets.to_i
      puts "Enter the commission"
      commission = gets.to_i
      cards[index] = Card.new(name:name, cost:cost, value:value, commission: commission)
    end

    def self.deck_size
      puts "How many custom deal cards?"
      gets.to_i
    end

  end

  class LoadedCards
    def self.arrangement
      load_cards
    end

    def self.load_cards
      cards = FileManager.command('load', 'deal deck')
      normalize(cards)
      cards
    end

    def self.normalize(data)
      data[:cards] = data[:cards].map{|k,v| [k.to_s.to_i, DealCards::Card.new(v)] }.to_h
      #data[:deal_deck] = DealDeck.new(cards: data[:deal_deck][:cards], deck: data[:deal_deck][:deck] )
    end

    # data[:deal_deck][:cards] = data[:deal_deck][:cards].map{|k,v| [k.to_s.to_i, DealCards::Card.new(v)] }.to_h
    # data[:deal_deck] = DealDeck.new(cards: data[:deal_deck][:cards], deck: data[:deal_deck][:deck] )

  end

  class RandomCards
    def self.arrangement
      random_cards
    end

    def self.random_cards
      cards={}
      (1..15).each {|card| cards[card] = random_card }
      cards
    end

    def self.random_card
      return Card.new(
              name: random_name,
              cost: random_cost,
              value: random_value,
              commission: random_commission
      )
    end

    def self.random_name
      %w(Show\ Pony Coffee\ Shop Electric\ Guitar BitCoin Hunting\ Rifle
        Exotic\ Puppy Gold\ Locket Alpaca\ Farm Smoothie\ Stand Season\ Tickets).sample
    end

    def self.random_cost
      random_amount(100,1500,100)
    end

    def self.random_value
      random_amount(300,3000, 200)
    end

    def self.random_commission
      random_amount(10,200,20)
    end

    def self.random_amount(min, max,step)
      Range.new(min,max).step(step).to_a.sample
    end
  end

  class DefaultCards
    def self.arrangement
      default_cards
    end

    def self.default_cards
      {
        1 => Card.new(name: 'Tractor', cost: 950, value: 1400, commission: 95),
        2 => Card.new(name: 'Quick Food Franchise', cost: 700, value: 1400, commission: 70),
        3 => Card.new(name: 'Stamp Collection', cost: 350, value: 600, commission: 50),
        4 => Card.new(name: 'Bottle Collection', cost: 200, value: 550, commission: 20),
        5 => Card.new(name: 'Share of a Race Horse', cost: 700, value: 1400, commission: 70),
        6 => Card.new(name: 'Coin Collection', cost: 500, value: 900, commission: 50),
        7 => Card.new(name: 'Used Sports Car', cost: 800, value: 1200, commission: 80),
        8 => Card.new(name: 'Two Acre Vacation Home', cost: 1000, value: 2500, commission: 100),
        9 => Card.new(name: 'Powerboat', cost: 1500, value: 2000, commission: 150),
        10 => Card.new(name: 'Family Camper', cost: 1100, value: 1600, commission: 110),
        11 => Card.new(name: "John Smith's Autograph", cost: 200, value: 550, commission: 20),
        12 => Card.new(name: 'Diamond Ring', cost: 350, value: 600, commission: 35),
        13 => Card.new(name: 'Unclaimed Furniture', cost: 150, value: 400, commission: 30),
        14 => Card.new(name: '600lbs of Copper Pipe', cost: 300, value: 650, commission: 30),
        15 => Card.new(name: 'Share in a Condo', cost: 1500, value: 2500, commission: 100),
        16 => Card.new(name: 'Antique Automobile', cost: 350, value: 600, commission: 50),
        17 => Card.new(name: 'Mysterious Gift', cost: rand(1..15)*100,
                       value: rand(1..30)*100, commission: rand(1..10)*10)
      }
    end

  end

end