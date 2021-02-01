class TeamsController < ApplicationController
  before_action :set_team, except: %i[index new create]

  def index
    @teams = policy_scope(Team)
    authorize @teams
  end

  def show; end

  def new
    @team = Team.new
    authorize @team
  end

  def create
    @team = Team.new(team_params)
    authorize @team

    if @team.save
      @team.logo.attach(team_params[:logo])
      redirect_to 'index', notice: 'Team created successfully.'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @team.update(team_params)
    redirect_to 'show', notice: 'Team updated successfully.'
  end

  def destroy
    @team.destroy
    redirect_to 'index', notice: 'Team destroyed successfully.'
  end

  private

    def set_team
      @team = Team.find(params[:id])
      authorize @team
    end

    def team_params
      params.require(:team).permit(policy(Team).permitted_attributes)
    end
end
