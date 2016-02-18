class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.timestamps
      t.string :name
      t.string :abbreviation
    end
  end
end
