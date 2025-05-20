class GamesController < ApplicationController
  before_action :set_game, only: [:show, :move]
  before_action :auto_join_player_o, only: [:show, :move]
  before_action :authorize_player!, only: [:show, :move]

  def new
    @game = Game.new
  end

  def create
    unless current_user
      redirect_to new_session_path, alert: "You must be logged in to create a game." and return
    end
    @game = GameCreator.new(current_user, against_ai: true).call
    redirect_to @game
  end

  def show
    if @game.player_o.nil? && current_user && @game.player_x != current_user
      @game.update(player_o: current_user, against_ai: false)
      Turbo::StreamsChannel.broadcast_replace_to(
        "game_#{@game.id}",
        target: "game",
        partial: "games/game_frame",
        locals: { game: @game }
      )
      flash[:notice] = "Tu as rejoint la partie !"
      redirect_to @game and return
    end
  end

  def move
    result = GameMoveHandler.new(@game, current_user, params[:index].to_i).call
    if result == :not_your_turn
      redirect_to @game, alert: "Ce n'est pas ton tour." and return
    end

    if @game.against_ai && @game.current_player == "O" && !@game.finished?
      AiMoveHandler.new(@game).call
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @game }
    end
  end

  def my_games
    unless current_user
      redirect_to new_session_path, alert: "Vous devez être connecté pour voir vos parties." and return
    end

    @games = current_user.games.order(created_at: :desc)
  end

  def invite
    @game = Game.find(params[:id])
    if @game.against_ai && @game.player_o.nil?
      @game.update(against_ai: false)
    end
    redirect_to @game, notice: "Lien d'invitation généré !"
  end

  def create_1v1
    invited_id = params[:invited_id]
    invited_user = User.find(invited_id)
    game = GameCreator.new(current_user, against_ai: false, invited_user: invited_user).call
    redirect_to game_path(game), notice: "Partie créée ! Partage le lien avec ton adversaire."
  end

  def join
    game = Game.find(params[:id])
    if game.player_o.nil?
      game.update(player_o: current_user, against_ai: false)
      # Diffuse la mise à jour à tous les abonnés Turbo Stream
      Turbo::StreamsChannel.broadcast_replace_to(
        "game_#{game.id}",
        target: "game",
        partial: "games/game_frame",
        locals: { game: game }
      )
      redirect_to game_path(game), notice: "Tu as rejoint la partie !"
    else
      redirect_to game_path(game), alert: "La partie est déjà complète."
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def auto_join_player_o
    if GameAutoJoiner.new(@game, current_user).call
      flash[:notice] = "Tu as rejoint la partie !"
      redirect_to @game and return
    end
  end

  def authorize_player!
    unless @game.players.include?(current_user)
      redirect_to root_path, alert: "Access denied."
    end
  end
end
