# frozen_string_literal: true


# access of the boards tiles returns a tile
# A tile is method returning a hash minimally filled with a key named effect
# optional keys - amount, name
# example tile {effect: 'mail' amount: 2}
module Board
  # TODO: merge default_tiles with given args hash for custom boards
  def self.tiles
    @default_tiles
  end

  def self.start
    { effect: 'start' }
  end

  def self.mail(letters)
    { effect: 'mail', amount: letters }
  end

  def self.deal
    { effect: 'deal' }
  end

  def self.sweet_sunday
    { effect: 'none' }
  end

  def self.buyer
    { effect: 'buyer' }
  end

  def self.poker_game
    { effect: 'poker' }
  end

  def self.bill(name, amount)
    { effect: 'bill', name: name, amount: amount }
  end

  def self.windfall(name, amount)
    { effect: 'windfall', name: name, amount: amount }
  end

  def self.town_election
    { effect: 'election', amount: 50 }
  end

  def self.daylight_savings
    { effect: 'dst' }
  end

  def self.lotto_draw
    { effect: 'lotto' }
  end

  def self.payday
    { effect: 'payday' }
  end

  @default_tiles = {
    0 => start,
    1 => mail(1),
    2 => windfall('inheritance', 500),
    3 => mail(3),
    4 => deal,
    5 => mail(2),
    6 => bill('weekend company', 50),
    7 => sweet_sunday,
    8 => windfall('surprise bonus', 100),
    9 => buyer,
    10 => poker_game,
    11 => mail(1),
    12 => deal,
    13 => bill('dance', 40),
    14 => sweet_sunday,
    15 => deal,
    16 => mail(3),
    17 => buyer,
    18 => bill('groceries', 75),
    19 => mail(1),
    20 => buyer,
    21 => sweet_sunday,
    22 => mail(1),
    23 => bill('home repairs', 50),
    24 => mail(2),
    25 => deal,
    26 => town_election,
    27 => daylight_savings,
    28 => sweet_sunday,
    29 => lotto_draw,
    30 => buyer,
    31 => payday
  }.freeze
end
