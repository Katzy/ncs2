class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :school
    change_table :users do |t|
      t.references :school, index: true
    end
  end
end