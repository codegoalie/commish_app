class FantasyTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :fantasy_league
  has_and_belongs_to_many :players, uniq: true

  attr_accessible :fantasy_league_id, :name

  def to_s
    name
  end
end
