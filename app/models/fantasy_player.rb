class FantasyPlayer < ActiveRecord::Base
  belongs_to :fantasy_team
  belongs_to :player

  attr_accessible :player, :starter

  delegate :to_s, :name, :position, :weekly_projection, :ffn_id,
    :team, to: :player
end
