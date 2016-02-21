class AddAlternateColumnToWrestler < ActiveRecord::Migration
  def change
     add_column :wrestlers, :alternate, :boolean
  end
end
