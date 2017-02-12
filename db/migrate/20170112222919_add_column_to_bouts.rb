class AddColumnToBouts < ActiveRecord::Migration
  def change
    add_column :bouts, :opponent_team, :string
  end
end
