class GameAutoJoiner
  def initialize(game, user)
    @game = game
    @user = user
  end

  def call
    return false unless @game.player_o.nil? && @user && @game.player_x != @user
    @game.update(player_o: @user, against_ai: false)
    true
  end
end 