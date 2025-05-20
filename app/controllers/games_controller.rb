class GamesController < ApplicationController
  before_action :set_game, only: [:show, :move]

  def new
    @game = Game.new
  end

  def create
    @game = Game.create!
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

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
