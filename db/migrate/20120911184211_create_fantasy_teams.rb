class CreateFantasyTeams < ActiveRecord::Migration
  def change
    create_table :fantasy_teams do |t|
      t.integer :user_id
      t.string :name
      t.string :league

      t.timestamps
    end
  end
end
