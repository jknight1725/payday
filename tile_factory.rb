require_relative 'Tiles'
# TODO: refactor
module TileFactory
  extend self

  def create(type)
    case type
    when 'default'
      default_tiles
    when 'custom'
      custom_tiles
    when 'random'
      random_tiles
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

  def custom_tiles
    tiles = {}
    (1..31).each {|day| tiles[day] = get_tile(day) }
    tiles
  end

  def get_tile(day)
    tile_choices = []
    Tiles.each_with_index do |tile, index|
      puts "#{index}\t#{tile[:effect]}"
      tile_choices << tile
    end

    choice = -1
    until (1..tile_choices.size).cover? choice
      puts "Pick a tile for day #{day}:\t"
      choice = gets.to_i
    end

    tile = tile_choices[choice]
    Tiles::set_tile_amount tile if tile.include? :amount
    Tiles::set_tile_name tile if tile.include? :name
    tile
  end


  def random_tiles
    tiles = {}
    (1..31).each do |day|
      tile_choices = []
      Tiles.each do|tile|
        tile[:amount] = rand(1100 / 100) * 100 + 100 if tile.include? :amount
        tile[:amount] = rand(1..5) if tile[:effect] == 'mail'
        tile[:name] = 'Taxes' if tile.include? :name
        tile_choices << tile
      end
      tiles[day] = tile_choices.sample
    end
    tiles
  end


  def default_tiles
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