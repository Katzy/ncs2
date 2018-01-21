class AddTourneyTeamToWrestler < ActiveRecord::Migration
  def change
    add_column :wrestlers, :tourney_team, :boolean
  end
end
