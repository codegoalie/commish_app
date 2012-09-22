class Injury < ActiveRecord::Base
  belongs_to :player

  scope :for_week, lambda {|week| where(week: week) }

  attr_accessible :game_status_desc, :injury_desc, :last_update, :player_id, :practice_status_desc, :week

  def status
    "#{injury_desc} <br> #{practice_status_desc} <br> #{game_status_desc}".html_safe
  end

  def self.update(current_week=Projection.current_week+1)
    injuries = FFNerd.injuries(current_week)

    while injuries.empty?
      current_week -= 1
      injuries = FFNerd.injuries(current_week)
    end

    injuries.each do |injury|
      next if injury[:id] == 0
      player = Player.find_by_ffn_id(injury[:id]) || 
        Player.create(ffn_id: injury[:id], name: injury[:name], position: injury[:position], team: injury[:team])

      if existing_injury = Injury.find_by_player_id_and_week(player.id, injury[:injury][:week])
        existing_injury.update_attributes(injury[:injury])
      else
        Injury.create({player_id: player.id}.merge(injury[:injury]))
      end
    end
  end
end
