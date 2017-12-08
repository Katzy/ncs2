class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.timestamps
      t.integer :start_date
      t.integer :end_date
      t.string :name
    end
  end
  
end
