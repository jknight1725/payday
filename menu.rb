require_relative 'game_factory'
require_relative 'board_factory'
require_relative 'menu_prompt'

game = nil
puts MenuPrompt::welcome
puts MenuPrompt::selections

case gets.to_i
when 1
  game = GameFactory.create('default')
when 2
  puts MenuPrompt::custom_game
  game = GameFactory.create('custom')
when 3
  puts MenuPrompt::load_game
  game = GameFactory.create('load')
when 4
  puts MenuPrompt::high_scores
  puts "none"
else
  exit("Invalid Selection")
end

game.run if game