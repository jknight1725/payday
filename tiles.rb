module Tiles
  #To add a new tile, def a method with at minimum an effect key, optional keys amount and name
  # default any args to nil
  # yield the new method in each
  include Enumerable
  extend self

  def each
    yield start
    yield mail
    yield deal
    yield sweet_sunday
    yield buyer
    yield poker_game
    yield bill
    yield windfall
    yield town_election
    yield daylight_savings
    yield lotto_draw
    yield payday
  end

  def start
    { effect: 'start' }
  end

  def mail(amount = nil)
    { effect: 'mail', amount: amount }
  end

  def deal
    { effect: 'deal' }
  end

  def sweet_sunday
    { effect: 'none' }
  end

  def buyer
    { effect: 'buyer' }
  end

  def poker_game
    { effect: 'poker' }
  end

  def bill(name = nil, amount = nil)
    { effect: 'bill', name: name, amount: amount }
  end

  def windfall(name = nil, amount = nil)
    { effect: 'windfall', name: name, amount: amount }
  end

  def town_election(amount = nil)
    { effect: 'election', amount: amount }
  end

  def daylight_savings
    { effect: 'dst' }
  end

  def lotto_draw
    { effect: 'lotto' }
  end

  def payday
    { effect: 'payday' }
  end



  def set_tile_amount(tile)
    puts "What is the amount/expense of #{tile[:effect]}\n"
    tile[:amount] = gets.to_i
  end

  def set_tile_name(tile)
    puts "What is the #{tile[:effect]} for?\n"
    tile[:name] = gets.chomp
  end
end