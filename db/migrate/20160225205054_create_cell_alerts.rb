class CreateCellAlerts < ActiveRecord::Migration
  def change
    create_table :cellnumbers do |t|
      t.timestamps
      t.string :cell
      t.string :carrier_name
      t.boolean :alert_106
      t.boolean :alert_113
      t.boolean :alert_120
      t.boolean :alert_126
      t.boolean :alert_132
      t.boolean :alert_138
      t.boolean :alert_145
      t.boolean :alert_152
      t.boolean :alert_160
      t.boolean :alert_170
      t.boolean :alert_182
      t.boolean :alert_195
      t.boolean :alert_220
      t.boolean :alert_285
    end
  end
end
