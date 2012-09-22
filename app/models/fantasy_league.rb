class FantasyLeague < ActiveRecord::Base
  has_many :fantasy_teams
  belongs_to :user

  attr_accessible :espn_id, :name, :year

  validates_presence_of :name

  def unclaimed_players
    Player.where("ffn_id not in (?)", players.map(&:ffn_id))
  end

  def players
    fantasy_teams.map{|t| t.players }.flatten
  end

  def update_rosters(team_id=nil)
    if team_id && team = fantasy_teams.find(team_id)
      team.update_roster
    else
      fantasy_teams.each do |t|
        t.update_roster
      end
    end
  end
end
