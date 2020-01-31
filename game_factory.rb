require_relative 'game'
require_relative 'player_factory'
require_relative 'builder'
require_relative 'file_manager'
# TODO loader class / isolate other behaviors
module GameFactory
  include Builder
  extend self

  def create(type)
    case type
    when default
      Game.new
    when custom
      Game.new(CustomGame.new.settings)
    when from_file
      Game.new(LoadedGame.new.settings)
    else
    raise NotImplementedError,
          "#{self} cannot respond to #{type}"
    end
  end

  class LoadedGame
    def settings
      load_game
    end

    def load_game
     game = FileManager.command('load', 'game')
     normalize(game)
    end

    #re-instantiate all objects via data
    def normalize(data)
      normalize_players data
      normalize_board data
      normalize_deals data
      data
    end

    def normalize_players(data)
      data[:players].each {|player| player[:bank] = RecordPad.new(player[:bank])}
      data[:players].map! {|p| Player.new(p)}
      data[:players].each {|player| player.deals.map!{|d| DealCards::Card.new(d) }}
    end

    def normalize_board(data)
      data[:board].transform_keys! {|k| k.to_s.to_i}
    end

    def normalize_deals(data)
      data[:deal_deck][:cards] = data[:deal_deck][:cards].map{|k,v| [k.to_s.to_i, DealCards::Card.new(v)] }.to_h
      data[:deal_deck] = DealDeck.new(cards: data[:deal_deck][:cards], deck: data[:deal_deck][:deck] )
    end

  end


  class CustomGame
    def settings
      custom_game
    end

    def custom_game
      options = {}
      options[:months]    = get_months
      options[:players]   = PlayerFactory.create_players_by_name
      options[:board]     = BoardFactory.create(Builder.build_for 'board')
      options[:deal_deck] = DealDeckFactory.create(Builder.build_for 'deal deck')
      options
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

end