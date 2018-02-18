class AddTallyToWrestler < ActiveRecord::Migration
  def change
    add_column :wrestlers, :win_tally, :integer
  end
end
