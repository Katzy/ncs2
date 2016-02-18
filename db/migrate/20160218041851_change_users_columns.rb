class ChangeUsersColumns < ActiveRecord::Migration
  def change
    remove_column :users, :league
    change_table :users do |t|
      t.references :league, index: true
    end
  end
end
