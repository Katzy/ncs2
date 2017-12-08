sclass CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.timestamps
      t.string :name
      t.string :abbreviation
      t.string :head_coach
      t.string :address
      t.integer :auth_users, null: false, default: 3
      t.references :league, index: true
    end
  end
end

