class Projection < ActiveRecord::Base
  belongs_to :player

  attr_accessible :ppr, :ppr_high, :ppr_low, :rank, :standard, :standard_high,
    :standard_low, :week, :player_id
end
