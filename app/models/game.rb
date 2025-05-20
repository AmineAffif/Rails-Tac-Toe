class Game < ApplicationRecord
  belongs_to :player_x, class_name: 'User', optional: true
  belongs_to :player_o, class_name: 'User', optional: true

  after_update_commit :broadcast_game_update

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

  def current_player_user
    current_player == "X" ? player_x : player_o
  end

  def current_user_symbol(user)
    return "X" if user == player_x
    return "O" if user == player_o
    nil
  end

  def finished?
    status != "playing"
  end

  private

  def broadcast_game_update
    Turbo::StreamsChannel.broadcast_replace_to(
      "game_#{id}",
      target: "game",
      partial: "games/game_frame",
      locals: { game: self }
    )
  end
end
