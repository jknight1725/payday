# frozen_string_literal: true
module DealCards
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

    def to_s
      "#{name}\nCost:\t#{cost} Value:\t#{value} Commission:\t#{commission}\n"
    end
  end

  def self.cards
    {
      Tractor: Card.new(name: 'Tractor', cost: 950, value: 1400, commission: 95),
      Quick_Food_Franchise: Card.new(name: 'Quick Food Franchise', cost: 700, value: 1400, commission: 70),
      Stamp_Collection: Card.new(name: 'Stamp Collection', cost: 350, value: 600, commission: 50),
      Bottle_Collection: Card.new(name: 'Bottle Collection', cost: 200, value: 550, commission: 20),
      Race_Horse: Card.new(name: 'Share of a Race Horse', cost: 700, value: 1400, commission: 70),
      Coin_Collection: Card.new(name: 'Coin Collection', cost: 500, value: 900, commission: 50),
      Sports_Car: Card.new(name: 'Used Sports Car', cost: 800, value: 1200, commission: 80),
      Vacationland: Card.new(name: 'Two Acre Vacation Home', cost: 1000, value: 2500, commission: 100),
      Powerboat: Card.new(name: 'Powerboat', cost: 1500, value: 2000, commission: 150),
      Family_Camper: Card.new(name: 'Family Camper', cost: 1100, value: 1600, commission: 110),
      John_Smith_Autograph: Card.new(name: "John Smith's Autograph", cost: 200, value: 550, commission: 20),
      Diamond_Ring: Card.new(name: 'Diamond Ring', cost: 350, value: 600, commission: 35),
      Furniture: Card.new(name: 'Unclaimed Furniture', cost: 150, value: 400, commission: 30),
      Copper_Pipe: Card.new(name: '600lbs of Copper Pipe', cost: 300, value: 650, commission: 30),
      Condo_Share: Card.new(name: 'Share in a Condo', cost: 1500, value: 2500, commission: 100),
      Antique_Auto: Card.new(name: 'Antique Automobile', cost: 350, value: 600, commission: 50),
      Mystery_Gift: Card.new(name: 'Mysterious Gift', cost: rand(1..15) * 100,
                             value: rand(1..30) * 100,
                             commission: rand(1..10) * 10)
    }.freeze
  end
end
