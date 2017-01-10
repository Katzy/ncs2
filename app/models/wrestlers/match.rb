class Wrestler < ActiveRecord::Base
 #get rid of file
  belongs_to :wrestler
  
  validates :date, presence: true, null: false
  validates :weight, presence: true, null: false
  validates :dual_or_tourney, presence: true, null: false
  validates :opponent_name, presence: true, null: false
  validates :win_loss, presence: true, null: false
  validates :result_type, presence: true, null: false
  validates :score_time, presence: true, null: false

  
end