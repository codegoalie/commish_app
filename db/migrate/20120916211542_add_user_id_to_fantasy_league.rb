class AddUserIdToFantasyLeague < ActiveRecord::Migration
  def change
    add_column :fantasy_leagues, :user_id, :integer
  end
end
