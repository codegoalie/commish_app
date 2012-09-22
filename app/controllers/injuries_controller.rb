class InjuriesController < ApplicationController

  def index
    @current_week = week_from_params_or_projections
    @injuries = Injury.where(week: @current_week)
    @latest_update = Injury.maximum('updated_at')
  end

  def update_all
    current_week = week_from_params_or_projections

    Injury.update(current_week)

    flash[:success] = "Injuries updated for week #{current_week}"
    redirect_to injuries_path
  end

  protected

    def week_from_params_or_projections
      params[:week] || Projection.maximum(:week)
    end
end
