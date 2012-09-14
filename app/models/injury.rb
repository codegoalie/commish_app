class Injury < ActiveRecord::Base
  belongs_to :player

  scope :for_week, lambda {|week| where(week: week) }

  attr_accessible :game_status_desc, :injury_desc, :last_update, :player_id, :practice_status_desc, :week
end
