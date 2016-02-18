class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.timestamps
      t.string :name
    end
  end
end
