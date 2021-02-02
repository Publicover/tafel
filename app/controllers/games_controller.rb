class GamesController < ApplicationController
  before_action :set_game, except: %i[index new create]
  before_action :set_teams, except: [:show, :destroy]

  def index
    @games = policy_scope(Game).order(created_at: :desc)
    authorize @games
    @game = Game.new
    authorize @game
  end

  def show; end

  def new
    @game = Game.new
    authorize @game
  end

  def create
    @game = Game.new(game_params)
    authorize @game

    respond_to do |format|
      if @game.save
        @game.create_scores
        format.html { redirect_to games_path, notice: 'Game created.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@game, partial: 'games/form', locals: { game: @game }) }
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    @game.update(game_params)
    redirect_to edit_game_path(@game)
  end

  def destroy
    @game.destroy
    redirect_to games_path, notice: 'Game destroyed.'
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
