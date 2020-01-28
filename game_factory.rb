require_relative 'game'
require_relative 'player_factory'
#require_relative 'deal_deck_factory'
require_relative 'builder'
# TODO loader class / isolate other behaviors
module GameFactory
  include Builder
  extend self

  def create(type)
    case type
    when default
      Game.new
    when custom
      Game.new(create_custom_game)
    when from_file
      Game.new(load_game)
    else
    raise NotImplementedError,
          "#{self} cannot respond to #{type}"
    end
  end

  def create_custom_game
    options = {}
    options[:players] = PlayerFactory.create_players
    options[:months] = get_months
    options[:board] = BoardFactory.create(Builder.get_build_for('board'))
    options[:deal_deck] =  DealDeckFactory.create(Builder.get_build_for('deal deck'))
    options
  end

  def load_game
    {}
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

