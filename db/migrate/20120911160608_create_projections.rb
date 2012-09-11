class CreateProjections < ActiveRecord::Migration
  def change
    create_table :projections do |t|
      t.integer :player_id
      t.integer :rank
      t.integer :week
      t.decimal :standard
      t.decimal :standard_low
      t.decimal :standard_high
      t.decimal :ppr
      t.decimal :ppr_low
      t.decimal :ppr_high

      t.timestamps
    end
  end
end
