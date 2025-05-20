class GameCreator
  def initialize(user, against_ai: true, invited_user: nil)
    @user = user
    @against_ai = against_ai
    @invited_user = invited_user
  end

  def call
    Game.create!(
      player_x: @user,
      player_o: @against_ai ? nil : @invited_user,
      against_ai: @against_ai
    )
  end
end 