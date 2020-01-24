module MenuPrompt
  extend self
  def welcome
    "Welcome to Payday!"
  end

  def selections
    "Pick an option below\n1. Quick Game\n2. Custom Game\n3. Load Game\n4. High Scores"
  end

  def custom_game
    "1. Create Custom Game\n2. Load Custom Game"
  end

  def load_game
    "Pick a game to load"
  end

  def high_scores
    "High scores of all time"
  end
end