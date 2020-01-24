require_relative 'game_factory'
require_relative 'board_factory'
require_relative 'menu_prompt'
include GameFactory

puts MenuPrompt::welcome
puts MenuPrompt::selections

def list_saved_games
  "1. moneybags"
end

def load_saved_game(choice)
  moneybags = {
      players: [Player.new(name: 'James', wallet: 9999), Player.new(name: 'Megan', wallet: 9999)],
      mail_deck: MailDeck.new,
      deal_deck: DealDeck.new,
      game_board: BoardFactory.for('default'),
      months: 1
  }
  moneybags unless choice != 1
end

def list_high_scores
  "none"
end

case gets.to_i
when 1
  Game.new.run
when 2
  puts MenuPrompt::custom_game
  Game.new(create_game).run
when 3
  puts MenuPrompt::load_game
  puts list_saved_games
  selection = gets.to_i
  Game.new(load_saved_game selection).run
when 4
  puts MenuPrompt::high_scores
  list_high_scores
else
  exit("Invalid Selection")
end


