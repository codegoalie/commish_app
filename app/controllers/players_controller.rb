class PlayersController < ApplicationController

  def index
    @players = Player.all
  end

  def show
    @player = Player.find params[:id]
    @projections = Projection.where(player_id: @player.id).order(:week)
    @injuries = @player.injuries.order('week desc')
  end
end
