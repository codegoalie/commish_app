class CreateFantasyTeamsPlayersLinkTable < ActiveRecord::Migration
  def change
    create_table :fantasy_teams_players do |t|
      t.integer :fantasy_team_id
      t.integer :player_id
    end
  end
end
