class CreateFantasyPlayers < ActiveRecord::Migration
  def change
    create_table :fantasy_players do |t|
      t.integer :fantasy_team_id
      t.integer :player_id
      t.boolean :starter

      t.timestamps
    end

    drop_table :fantasy_teams_players
  end
end
