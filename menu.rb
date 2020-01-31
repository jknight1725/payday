require_relative 'menu_prompt'
require_relative 'game_factory'
require_relative 'builder'

game = nil
puts MenuPrompt::welcome
puts MenuPrompt::selections
choice = gets.to_i

case choice
when 1
  game = GameFactory.create(Builder.default)
when 2
  game = GameFactory.create(Builder.custom)
when 3
  game = GameFactory.create(Builder.from_file)
when 4
  puts MenuPrompt::high_scores
  puts "none"
else
  exit("Invalid Selection")
end

game.run if game