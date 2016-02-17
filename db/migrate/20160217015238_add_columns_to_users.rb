class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :school, :string
    add_column :users, :league, :string
    add_column :users, :league_rep, :boolean
    add_column :users, :cell, :string
    add_column :users, :admin, :boolean
  end
end
