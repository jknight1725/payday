# frozen_string_literal: true
module GamePrompt
  def self.roll(name, roll, position)
    "\n#{name} your turn!\n\nYou rolled a #{roll} landing on day #{position}\n"
  end

  def self.end_turn(name)
    puts "\nEnd of your turn #{name}!\n"
    confirm
  end

  def self.dst
    "Daylight savings time! All players move back one space!\n"
  end

  def self.game_over(name, months, score)
    "Game Over #{name} you played all #{months} months\nYour score:\t#{score}\n"
  end

  def self.results
    "\nFinal Scores!\n"
  end

  def self.confirm
    puts "Press enter to continue..."
    STDIN.getc
  end
end