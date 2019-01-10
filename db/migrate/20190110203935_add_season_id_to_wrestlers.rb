class AddSeasonIdToWrestlers < ActiveRecord::Migration
  def change
    add_column :wrestlers, :season_id, :integer
  end
end
