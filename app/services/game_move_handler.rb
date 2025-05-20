class GameMoveHandler
  def initialize(game, user, index)
    @game = game
    @user = user
    @index = index
  end

  def call
    return :not_your_turn unless @game.current_player_user == @user
    symbol = @game.current_user_symbol(@user)
    @game.play_move(@index, symbol)
    :ok
  end
end 