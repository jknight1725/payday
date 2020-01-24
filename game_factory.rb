require_relative 'game'
module GameFactory
  extend self

  def create_game
    options = {}
    options[:players] = get_players
    options[:game_board] = BoardFactory.for(get_board_type)
    options[:months] = get_months
    options[:deal_deck] =  DealDeck.new(cards: (get_deal_deck custom_deck={}), deck: custom_deck.keys)
    Game.new(options)
  end

  def get_players
    puts "How many players?"
    n = gets.to_i
    names = []
    (1..n).each {|no| puts "Enter a name for Player ##{no}:\t "; names << gets.chomp  }
    names.map {|name| Player.new(name: name) }
  end

  def get_board_type
    options = BoardFactory.options
    options.each_with_index { |opt, index | puts "#{index+1}\t#{opt}" }

    choice = -1
    until (1..options.size).cover? choice
      puts "Pick an option:\t"
      choice = gets.to_i
    end
    options[choice-1]
  end

  def get_months
    puts "How many months would you like to play?"
    months = -1
    until months.positive?
      puts "Enter a positive number"
      months = gets.to_i
    end
    months
  end

  def get_deals(deck)
    puts "Enter the name of the deal"
    name = gets.chomp
    puts "Enter the cost"
    cost = gets.to_i
    puts "Enter the value"
    value = gets.to_i
    puts "Enter the commission"
    commission = gets.to_i
    deck[name.to_sym] = DealCards::Card.new(name:name, cost:cost, value:value, commission: commission)
  end

  def deck_size
    puts "How many custom deal cards?"
    gets.to_i
  end

  def get_deal_deck(deck)
    deck_size.times {get_deals deck}
  end

end