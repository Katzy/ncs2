class AddColumnsToBouts < ActiveRecord::Migration
  def change
    add_column(:bouts, :created_at, :datetime)
    add_column(:bouts, :updated_at, :datetime)
  end
end
