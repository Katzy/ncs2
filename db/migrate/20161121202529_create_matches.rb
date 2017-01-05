class CreateMatches < ActiveRecord::Migration
  def change
    create_table :bouts do |t|
      t.string :date
      t.string :weight
      t.string :dual_or_tourney
      t.string :tourney_name
      t.integer :tourney_seed
      t.string :opponent_name
      t.string :win_loss
      t.string :result_type
      t.string :score_time
      t.integer :tourney_place
      t.references :wrestler, index: true
    end
  end
end
