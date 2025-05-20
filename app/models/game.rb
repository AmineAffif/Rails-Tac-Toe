class Game < ApplicationRecord
  # Callbacks
  before_create :initialize_board

  # Initialize the board
  def initialize_board
    self.state ||= Array.new(9, nil)
    self.current_player ||= "X"
    self.status ||= "playing"
  end

  # Apply a move (index = 0 to 8)
  def play_move(index, symbol)
    GameEngine.new(self).play_move(index, symbol)
  end

  def finished?
    status != "playing"
  end
end
