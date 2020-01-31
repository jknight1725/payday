require_relative 'player'
module PlayerFactory

  def self.create_players_by_name
    puts "How many players?"
    n = gets.to_i
    names = []
    (1..n).each {|no| puts "Enter a name for Player ##{no}:\t "; names << gets.chomp  }
    names.map {|name| Player.new(name: name) }
  end
end