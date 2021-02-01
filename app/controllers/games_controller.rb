class GamesController < ApplicationController
  before_action :set_game, except: %i[index new create]
  before_action :set_teams, only: %i[new create edit update]

  def index
    @games = policy_scope(Game)
    authorize @games
  end

  def show; end

  def new
    @game = Game.new
    authorize @game
  end

  def create
    @game = Game.new(game_params)
    authorize @game

    if @game.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def edit; end

  def update
    @game.update(game_params)
    redirect_to game_path(@game)
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

    def set_game
      @game = Game.find(params[:id])
      authorize @game
    end

    def set_teams
      @teams = Team.all
    end

    def game_params
      params.require(:game).permit(policy(Game).permitted_attributes)
    end
end
