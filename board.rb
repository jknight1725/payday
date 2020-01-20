# frozen_string_literal: true

require_relative 'tiles'
# access of the board returns a tile
# A tile is method returning a hash minimally filled with a key named effect
# optional keys - amount, name
# example tile {effect: 'mail' amount: 2}
# TODO: board factory
class Board
  include Tiles
  attr_reader :board
  def initialize(args={})
    @board = defaults.merge args
  end

  def defaults
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
