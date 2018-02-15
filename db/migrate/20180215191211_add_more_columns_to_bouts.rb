class AddMoreColumnsToBouts < ActiveRecord::Migration
  def change
    add_column :bouts, :first_name, :string
    add_column :bouts, :last_name, :string
    add_column :bouts, :school_id, :integer
  end
end
