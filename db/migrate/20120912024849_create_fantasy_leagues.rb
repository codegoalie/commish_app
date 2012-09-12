class CreateFantasyLeagues < ActiveRecord::Migration
  def change
    create_table :fantasy_leagues do |t|
      t.string :name
      t.integer :espn_id
      t.integer :year

      t.timestamps
    end
  end
end
