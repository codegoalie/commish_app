class AddEspnIdToFantasyTeams < ActiveRecord::Migration
  def change
    add_column :fantasy_teams, :espn_id, :integer
  end
end
