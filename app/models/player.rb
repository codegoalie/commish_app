class Player < ActiveRecord::Base
  has_many :projections
  has_and_belongs_to_many :fantasy_teams

  scope :by_name, order(:name)
  scope :by_team, order(:team)
  scope :by_position, order(:position)
  scope :position, lambda { |position| where(position: position) }

  attr_accessible :name, :position, :team, :ffn_id

  def to_s
    "#{name} (#{ffn_id})"
  end
end

