class AddTourneysToWrestler < ActiveRecord::Migration
  def change
    add_column :wrestlers, :t6_name, :string
    add_column :wrestlers, :t7_name, :string
    add_column :wrestlers, :t8_name, :string
    add_column :wrestlers, :t6_place, :integer
    add_column :wrestlers, :t7_place, :integer
    add_column :wrestlers, :t8_place, :integer
  end
end
