require_relative 'game'
require_relative 'player_factory'
require_relative 'deal_deck_factory'
# TODO loader class / isolate other behaviors
module GameFactory
  extend self

  def create(type)
    case type
    when 'default'
      Game.new
    when 'custom'
      Game.new(create_custom_game)
    when 'load'
      Game.new(load_game)
    else
    raise NotImplementedError,
          "#{self} cannot respond to #{type}"
    end
  end

  def create_custom_game
    options = {}
    options[:players] = PlayerFactory::create_players
    options[:months] = get_months
    options[:game_board] = BoardFactory::create(board_type)
    options[:deal_deck] =  DealDeckFactory::create('custom')
    options
  end

  def load_game
    {}
  end

  def board_type
    puts "Pick a Board type"
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

end

