class AddLeagueToWrestler < ActiveRecord::Migration
  def change
    add_column :wrestlers, :league_1ya, :string
  end
end
