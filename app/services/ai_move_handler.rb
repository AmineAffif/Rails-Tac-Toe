class AiMoveHandler
  def initialize(game)
    @game = game
  end

  def call
    return false unless @game.against_ai && @game.current_player == "O" && !@game.finished?
    
    move_index = RandomBot.pick_move(@game)
    @game.play_move(move_index, "O")
    true
  end
end 