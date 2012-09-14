class AddStaterToFantasyTeamsPlayers < ActiveRecord::Migration
  def change
    add_column :fantasy_teams_players, :starter, :boolean
  end
end
