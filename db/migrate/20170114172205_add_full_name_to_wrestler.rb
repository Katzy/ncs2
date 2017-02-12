class AddFullNameToWrestler < ActiveRecord::Migration
  def change
    add_column :wrestlers, :fullname, :string
  end
end
