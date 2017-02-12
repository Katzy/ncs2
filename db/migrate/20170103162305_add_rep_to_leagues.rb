class AddRepToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :league_rep, :string
  end
end
