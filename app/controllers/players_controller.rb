class PlayersController < ApplicationController

  def index
    @players = Player.by_position
  end
end
