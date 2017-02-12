class AddRoleColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coach, :boolean
    add_column :users, :asst, :boolean
  end
end
