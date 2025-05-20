class Game < ApplicationRecord
  # Constants
  WINNING_COMBINATIONS = [
    [0, 1, 2], # row 1
    [3, 4, 5], # row 2
    [6, 7, 8], # row 3
    [0, 3, 6], # column 1
    [1, 4, 7], # column 2
    [2, 5, 8], # column 3
    [0, 4, 8], # diagonal
    [2, 4, 6]  # diagonal
  ]

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
    return false unless state[index].nil? && status == "playing"

    state[index] = symbol
    check_game_status(symbol)
    toggle_player unless finished?
    save
  end

  # Check if the game is won or drawn
  def check_game_status(symbol)
    if winner?(symbol)
      self.status = "won"
      self.winner = symbol
    elsif draw?
      self.status = "draw"
    end
  end

  # Switch players
  def toggle_player
    self.current_player = (current_player == "X" ? "O" : "X")
  end

  # Winner?
  def winner?(symbol)
    WINNING_COMBINATIONS.any? do |line|
      line.all? { |i| state[i] == symbol }
    end
  end

  # Draw?
  def draw?
    state.all?
  end

  def finished?
    status != "playing"
  end
end
