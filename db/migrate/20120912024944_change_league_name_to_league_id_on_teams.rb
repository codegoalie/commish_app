class ChangeLeagueNameToLeagueIdOnTeams < ActiveRecord::Migration
  def change
    add_column :fantasy_teams, :fantasy_league_id, :integer
    remove_column :fantasy_teams, :league
  end
end
