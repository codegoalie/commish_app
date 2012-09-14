class CreateInjuries < ActiveRecord::Migration
  def change
    create_table :injuries do |t|
      t.integer :player_id
      t.integer :week
      t.string :injury_desc
      t.string :practice_status_desc
      t.string :game_status_desc
      t.timestamp :last_update

      t.timestamps
    end
  end
end
