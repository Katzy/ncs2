class AddColumnsToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :cell, :string
    add_column :leagues, :email, :string
  end
end
