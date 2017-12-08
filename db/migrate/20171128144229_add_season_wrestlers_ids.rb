class AddSeasonWrestlersIds < ActiveRecord::Migration
def change 
    create_table :season_wrestlers do |t|
      t.timestamps
      t.belongs_to :season, index: true
      t.belongs_to :wrestler, index: true
      t.integer :wrestler_school_id
      t.integer :wrestler_grade
      t.string :first_name
      t.string :last_name
    end
  end
end
