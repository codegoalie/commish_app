class FantasyTeamsController < ApplicationController

  def index
    @fantasy_teams = FantasyTeam.where(user_id: current_user.id)
  end

  def show
    @fantasy_team = FantasyTeam.find(params[:id])
    @players = @fantasy_team.players
    @current_week = Projection.maximum(:week)
    @total_points = 0
    @players.each{|p| @total_points += p.projections.for_week(@current_week).first.standard.round(2) }
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
    @fantasy_team = FantasyTeam.find(params[:id])
  end

  def update
    @fantasy_team = FantasyTeam.find(params[:id])

    if @fantasy_team.update_attributes(params[:fantasy_team])
      flash[:success] = "Updated #{@fantasy_team.name}"
      redirect_to @fantasy_team
    else
      render 'edit'
    end
  end

  def destroy
  end

  def update_team_roster
  end
end
