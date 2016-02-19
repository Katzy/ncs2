class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.timestamps
      t.string :name, :null => false
    end
  end
end
