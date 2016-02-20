class ChangeWrestlerColumn < ActiveRecord::Migration
  def change
    change_column :wrestlers, :league_place, :string
  end
end
