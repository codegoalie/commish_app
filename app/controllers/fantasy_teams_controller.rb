class FantasyTeamsController < ApplicationController

  def index
    @fantasy_teams = FantasyTeam.where(user_id: current_user.id)
  end

  def show
    @fantasy_team = FantasyTeam.find(params[:id])
  end

  def new
    @fantasy_team = FantasyTeam.new
  end

  def create
    @fantasy_team = FantasyTeam.new(params[:fantasy_team])
    current_user.fantasy_teams << @fantasy_team

    if @fantasy_team.save
      flash[:success] = "Created #{@fantasy_team.name}"
      redirect_to @fantasy_team
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
