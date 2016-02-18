class CreateWrestlers < ActiveRecord::Migration
  def change
    create_table :wrestlers do |t|
      t.timestamps
      t.string :first_name
      t.string :last_name
      t.string :school
      t.string :league
      t.integer :weight
      t.integer :grade
      t.integer :wins
      t.integer :losses
      t.integer :seed
      t.integer :section_place
      t.integer :state_place
      t.string :t1_name
      t.integer :t1_place
      t.string :t2_name
      t.integer :t2_place
      t.string :t3_name
      t.integer :t3_place
      t.string :t4_name
      t.integer :t4_place
      t.string :t5_name
      t.integer :t5_place
      t.string :h2h_1
      t.string :h2h_r1
      t.string :h2h_2
      t.string :h2h_r2
      t.string :h2h_3
      t.string :h2h_r3
      t.string :h2h_4
      t.string :h2h_r4
      t.string :h2h_5
      t.string :h2h_r5
      t.text :comments
      t.references :school, index: true
    end
  end
end
