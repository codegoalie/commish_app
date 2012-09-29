class FantasyTeamsController < ApplicationController

  def index
    @fantasy_teams = FantasyTeam.where(user_id: current_user.id)
  end

  def show
    @fantasy_team = FantasyTeam.find(params[:id])
    @fantasy_players = @fantasy_team.fantasy_players
    @players = @fantasy_players.map(&:player)
    @current_week = Projection.maximum(:week)
    @total_points = @fantasy_team.weekly_projection(@current_week)
    @projections = Projection.for_week(@current_week).order(:standard)
    @fantasy_league = @fantasy_team.fantasy_league
    @league_players = @fantasy_league.players
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

  def update_roster
    @fantasy_team = FantasyTeam.find(params[:id])

    errors = @fantasy_team.update_roster

    if errors.any?
      flash[:alert] = errors.join("<br>").html_safe
    else
      flash[:success] = 'Roster updated successfully.'
    end

    redirect_to @fantasy_team
  end
end
