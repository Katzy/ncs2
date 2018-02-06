class AddGirlsToWrestler < ActiveRecord::Migration
  def change
    add_column :wrestlers, :sex, :boolean
  end
end
