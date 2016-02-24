class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
       t.timestamps
       t.string :msg
       t.references :conversation, index: true
    end
  end
end