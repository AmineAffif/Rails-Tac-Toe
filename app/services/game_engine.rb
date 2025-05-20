class GameEngine
  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def initialize(game)
    @game = game
  end

  def play_move(index, symbol)
    return false unless @game.state[index].nil? && @game.status == "playing"

    @game.state[index] = symbol
    check_game_status(symbol)
    toggle_player unless finished?
    @game.save
  end

  def check_game_status(symbol)
    if winner?(symbol)
      @game.status = "won"
      @game.winner = symbol
    elsif draw?
      @game.status = "draw"
    end
  end

  def toggle_player
    @game.current_player = (@game.current_player == "X" ? "O" : "X")
  end

  def winner?(symbol)
    WINNING_COMBINATIONS.any? do |line|
      line.all? { |i| @game.state[i] == symbol }
    end
  end

  def draw?
    @game.state.all?
  end

  def finished?
    @game.status != "playing"
  end
end 