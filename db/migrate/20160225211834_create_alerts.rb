class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.timestamps
      t.text :message, :limit => 255
    end
  end
end