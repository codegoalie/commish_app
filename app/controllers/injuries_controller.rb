class InjuriesController < ApplicationController

  def index
    @current_week = week_from_params_or_projections
    @injuries = Injury.where(week: @current_week)
  end

  def update_all
    current_week = week_from_params_or_projections
    injuries = FFNerd.injuries(current_week)

    injuries.each do |injury|
      next if injury[:id] == 0
      player = Player.find_by_ffn_id(injury[:id]) || 
        Player.create(ffn_id: injury[:id], name: injury[:name], position: injury[:position], team: injury[:team])

      if existing_injury = Injury.find_by_player_id_and_week(player.id, injury[:injury][:week])
        existing_injury.update_attributes(injury[:injury])
      else
        Injury.create({player_id: player.id}.merge(injury[:injury]))
      end
    end
    redirect_to injuries_path
  end

  protected

    def week_from_params_or_projections
      params[:week] || Projection.maximum(:week)
    end
end
