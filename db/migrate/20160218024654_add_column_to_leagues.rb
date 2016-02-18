class AddColumnToLeagues < ActiveRecord::Migration
  def change
     add_column :leagues, :entries, :integer
  end
end
