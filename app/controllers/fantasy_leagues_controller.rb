class FantasyLeaguesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @fantasy_leagues = FantasyLeague.all
  end

  def show
    @fantasy_league = FantasyLeague.find(params[:id])
    @current_week = Projection.maximum(:week)

    @unclaimed_players = @fantasy_league.unclaimed_players.with_weekly_projections(@current_week)
  end

  def new
    @fantasy_league = FantasyLeague.new
  end

  def create
    @fantasy_league = FantasyLeague.new(params[:fantasy_league])

    if @fantasy_league.save
      current_user.fantasy_leagues << @fantasy_league
      flash[:success] = "#{@fantasy_league.name} created."
      redirect_to @fantasy_league
    else
      render 'new'
    end
  end

  def edit
    @fantasy_league = FantasyLeague.find(params[:id])
  end

  def update
    @fantasy_league = FantasyLeague.find(params[:id])

    if @fantasy_league = FantasyLeague.update_attributes(params[:fantasy_league])
      flash[:success] = "#{@fantasy_league.name} updated."
      redirect_to @fantasy_league
    else
      render 'new'
    end
  end

  def delete
    @fantasy_league = FantasyLeague.find(params[:id])

    @fantasy_league.destroy

    flash[:notice] = "#{@fantasy_league.name} deleted."
    redirect_to fantasy_leagues_path
  end

  def update_rosters
    @fantasy_league = FantasyLeague.find(params[:id])

    errors = []
    @fantasy_league.fantasy_teams.each do |team|
      errors + team.update_roster.map{|e| "#{team.name}: #{e}"}
    end

    if errors.any?
      flash[:alert] = errors.join("<br>").html_safe
    else
      flash[:success] = 'Rosters updated successfully.'
    end

    redirect_to @fantasy_league
  end
end
