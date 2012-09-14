class FantasyLeague < ActiveRecord::Base
  has_many :fantasy_teams

  attr_accessible :espn_id, :name, :year

  validates_presence_of :name

  def unclaimed_players
    Player.where("ffn_id not in (?)", players.map(&:ffn_id))
  end

  def players
    fantasy_teams.map{|t| t.players }.flatten
  end
end
