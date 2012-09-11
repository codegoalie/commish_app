class FantasyTeam < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :players

  attr_accessible :league, :name, :user_id

  def to_s
    name
  end
end
