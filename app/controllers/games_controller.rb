class GamesController < ApplicationController
  before_action :set_game, only: [:show, :move]
  before_action :authorize_player!, only: [:show, :move]

  def new
    @game = Game.new
  end

  def create
    unless current_user
      redirect_to new_session_path, alert: "You must be logged in to create a game." and return
    end
    @game = Game.create!(
      player_x: current_user,
      player_o: nil,
      against_ai: true
    )
    redirect_to @game
  end

  def show
  end

  def move
    index = params[:index].to_i

    # 🧠 1. Player plays
    if @game.current_player == "X"
      @game.play_move(index, "X")
    end

    # 🧠 2. AI plays if the game continues
    if !@game.finished? && @game.current_player == "O"
      bot_move = RandomBot.pick_move(@game)
      @game.play_move(bot_move, "O")
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


  private

  def set_game
    @game = Game.find(params[:id])
  end

  def authorize_player!
    unless @game.players.include?(current_user)
      redirect_to root_path, alert: "Access denied."
    end
  end
end
