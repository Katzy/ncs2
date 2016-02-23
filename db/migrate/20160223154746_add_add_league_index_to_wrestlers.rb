class AddAddLeagueIndexToWrestlers < ActiveRecord::Migration
  def change
    add_reference :wrestlers, :league, index: true
  end
end
