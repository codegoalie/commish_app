class FantasyLeague < ActiveRecord::Base
  has_many :fantasy_teams

  attr_accessible :espn_id, :name, :year

  validates_presence_of :name
end
