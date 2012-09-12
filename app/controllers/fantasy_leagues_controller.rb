class FantasyLeaguesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @fantasy_leagues = FantasyLeague.all
  end

  def show
    @fantasy_league = FantasyLeague.find(params[:id])
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
end
