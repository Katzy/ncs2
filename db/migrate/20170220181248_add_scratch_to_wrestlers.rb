class AddScratchToWrestlers < ActiveRecord::Migration
  def change
    add_column :wrestlers, :scratch, :boolean
  end
end
