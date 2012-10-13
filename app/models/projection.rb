class Projection < ActiveRecord::Base
  belongs_to :player

  scope :for_week, lambda {|week| where(week: week) }
  scope :by_points, order('standard desc')

  attr_accessible :ppr, :ppr_high, :ppr_low, :rank, :standard, :standard_high,
    :standard_low, :week, :player_id

  def self.current_week
    maximum(:week) || 1
  end
end
