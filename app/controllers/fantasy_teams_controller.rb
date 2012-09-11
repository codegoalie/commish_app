class FantasyTeamsController < ApplicationController

  def index
    @fantasy_teams = FantasyTeam.where(user_id: current_user.id)
  end

  def show
    @fantasy_team = FantasyTeam.find(params[:id])
    @players = @fantasy_team.players
    @current_week = Projection.maximum(:week)
    @total_points = 0
    @players.each{|p| @total_points += p.projections.for_week(@current_week).first.standard }
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
