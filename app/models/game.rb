class Game < ApplicationRecord
  belongs_to :player_x, class_name: 'User', optional: true
  belongs_to :player_o, class_name: 'User', optional: true

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

  def players
    [player_x, player_o].compact
  end

  def finished?
    status != "playing"
  end
end
