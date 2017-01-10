class Bout < ActiveRecord::Base

  belongs_to :wrestler
  
  validates :date, presence: true, null: false
  validates :weight, presence: true, null: false
  validates :dual_or_tourney, presence: true, null: false
  validates :opponent_name, presence: true, null: false
  validates :win_loss, presence: true, null: false
  validates :result_type, presence: true, null: false
  validates :score_time, presence: true, null: false


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Bout.create! row.to_hash
    end
  end
end