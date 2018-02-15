class Bout < ActiveRecord::Base
  acts_as_xlsx

  belongs_to :wrestler
  # belongs_to :season_wrestler
  
  validates :weight, presence: true, null: false
  # validates :dual_or_tourney, presence: true, null: false
  
  validates :opponent_name, presence: true, null: false
  validates :win_loss, presence: true, null: false
  # validates :result_type, presence: true, null: false
  validates :score_time, presence: true, null: false
  # validates :opponent_team, presence: true, null: false


  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row[3] = Season.last.wrestlers.where(last_name: row[0], first_name: row[1], school_id: row[2])[0].id
       Bout.create! row.to_hash
      
    end
  end

  def self.to_csv(options = {}, example)
    CSV.generate(options) do |csv|
      csv << ["date", "weight", "last_name", "first_name", "dual_or_tourney", "tourney_name", "tourney_seed", "opponent_team", "opponent_name", "win_loss", "result_type", "score_time", "tourney_place"]

      example.each do |bout|
       csv << [wrestler.weight, wrestler.first_name, wrestler.last_name, wrestler.school.league.name, wrestler.school.name, wrestler.school.abbreviation, wrestler.grade, wrestler.wins, wrestler.losses, wrestler.seed, wrestler.league_place, wrestler.section_place, wrestler.state_place]
      end
    end
  end
end
