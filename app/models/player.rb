class Player < ActiveRecord::Base
  has_many :projections
  has_many :fantasy_players
  has_many :fantasy_teams, through: :fantasy_players
  has_many :injuries

  scope :by_name, order(:name)
  scope :by_team, order(:team)
  scope :by_position, order(:position)
  scope :position, lambda { |position| where(position: position) }
  scope :with_weekly_projections, lambda {|week| joins(:projections).where('projections.week = ?', week).order('projections.standard desc') }

  attr_accessible :name, :position, :team, :ffn_id

  def to_s
    name
  end

  def weekly_projection(week, type=:standard)
    if projection = projections.for_week(week).first
      (projection.send(type) || 0).round(2)
    else
      0
    end
  end
end

