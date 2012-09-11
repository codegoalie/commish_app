class WeeksController < ApplicationController

  def index
    @weeks = Projection.select('distinct week').map(&:week)
  end

  def show
    @week = params[:id]
    @projections = Projection.includes(:player).where(week: @week).order(:rank)
  end
end
