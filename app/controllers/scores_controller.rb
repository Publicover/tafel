# frozen_string_literal: true

class ScoresController < ApplicationController
  before_action :set_score, except: [:index, :new, :create]

  def index
    @scores = Score.all
    authorize @scores
  end

  def show
  end

  def new
    @score = Score.new
    authorize @score
  end

  def create
    @score = Score.new(score_params)
    authorize @score

    if @score.save
      redirect_to score_path(@score)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @score.update(score_params)
  end

  def destroy
    @score.destroy
    redirect_to scores_path
  end

  private

    def set_score
      @score = Score.find(params[:id])
      authorize @score
    end

    def score_params
      params.require(:score).permit(policy(Score).permitted_attributes)
    end
end
