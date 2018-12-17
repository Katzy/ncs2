class RemoveSexFromWrestlerAdd < ActiveRecord::Migration
  def change
    remove_column :wrestlers, :sex, :boolean
    add_column :wrestlers, :gender, :string
  end
end
