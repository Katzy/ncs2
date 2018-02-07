class AddLossesNcsToWrestler < ActiveRecord::Migration
  def change
    add_column :wrestlers, :losses_ncs, :integer
  end
end
