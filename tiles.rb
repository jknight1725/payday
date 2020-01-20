module Tiles
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

  def self.town_election(amount)
    { effect: 'election', amount: amount }
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
end