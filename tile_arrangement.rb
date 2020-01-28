require_relative 'tiles'
require_relative 'builder'
module TileArrangement
  include Builder
  extend self

  def for(type)
    case type
    when default
      DefaultTiles.arrangement
    when custom
      CustomTiles.arrangement
    when random
      RandomTiles.arrangement
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

  class CustomTiles

    def self.arrangement
      custom_tiles
    end

    def self.custom_tiles
      tiles = {0 => Tiles.start}
      (1..30).each {|day| tiles[day] = custom_tile(day) }
      tiles[31] = Tiles.payday
      tiles
    end

    def self.custom_tile(day)
      tile_choices = Tiles.to_a
      Tiles.each_with_index { |tile, index| puts "#{index}\t#{tile[:effect]}" }
      choice = -1

      until (0..tile_choices.size).cover? choice
        puts "Pick a tile for day #{day}:\t"
        choice = gets.to_i
      end

      tile = tile_choices[choice]
      Tiles.set_tile_amount tile if tile.include? :amount
      Tiles.set_tile_name tile if tile.include? :name

      tile
    end
  end

  class RandomTiles

    def self.arrangement
      random_tiles
    end

    def self.random_tiles
      tiles = {0 => Tiles.start}
      (1..30).each {|day| tiles[day] = random_tile }
      tiles[31] = Tiles.payday
      tiles
    end

    def self.random_tile
      tile = Tiles.to_a.sample
      tile[:amount] = random_amount if tile.include? :amount
      tile[:amount] = rand(1..5) if tile[:effect] == 'mail'
      tile[:name] = random_name if tile.include? :name
      tile
    end

    def self.random_name
      %w(Taxes Billing\ Error Gambling Lawsuit Garage\ Sale).sample
    end

    def self.random_amount
      Range.new(100,1200).step(100).to_a.sample
    end
  end

  class DefaultTiles

    def self.arrangement
      default_tiles
    end

    def self.default_tiles
      {
        0 => Tiles.start,
        1 => Tiles.mail(1),
        2 => Tiles.windfall('inheritance', 500),
        3 => Tiles.mail(3),
        4 => Tiles.deal,
        5 => Tiles.mail(2),
        6 => Tiles.bill('weekend company', 50),
        7 => Tiles.sweet_sunday,
        8 => Tiles.windfall('surprise bonus', 100),
        9 => Tiles.buyer,
        10 => Tiles.poker_game,
        11 => Tiles.mail(1),
        12 => Tiles.deal,
        13 => Tiles.bill('dance', 40),
        14 => Tiles.sweet_sunday,
        15 => Tiles.deal,
        16 => Tiles.mail(3),
        17 => Tiles.buyer,
        18 => Tiles.bill('groceries', 75),
        19 => Tiles.mail(1),
        20 => Tiles.buyer,
        21 => Tiles.sweet_sunday,
        22 => Tiles.mail(1),
        23 => Tiles.bill('home repairs', 50),
        24 => Tiles.mail(2),
        25 => Tiles.deal,
        26 => Tiles.town_election(50),
        27 => Tiles.daylight_savings,
        28 => Tiles.sweet_sunday,
        29 => Tiles.lotto_draw,
        30 => Tiles.buyer,
        31 => Tiles.payday
      }
    end
  end

end