class FantasyLeague < ActiveRecord::Base
  has_many :fantasy_teams

  attr_accessible :espn_id, :name, :year

  validates_presence_of :name

  def unclaimed_players
    Player.where("ffn_id not in (?)", claimed_players.map(&:ffn_id))
  end

  def claimed_players
    fantasy_teams.map{|t| t.players }.flatten
  end
end
