class AddSectionToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :section, :string
  end
end
