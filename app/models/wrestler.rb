class Wrestler < ActiveRecord::Base

  belongs_to :school

  validates :first_name, presence: true, null: false
  validates :last_name, presence: true, null: false
  validates :weight, presence: true, null: false
  validates :school_id, presence: true, null: false
  validates :losses, presence: true, null: false
  validates :wins, presence: true, null: false
  validates_uniqueness_of :weight, scope: :school_id

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["weight", "full name", "school", "abbreviation", "grade", "wins", "losses", "SEED", "SEC", "ST", "Comments"]

      all.each do |wrestler|
       csv << [wrestler.weight, wrestler.first_name + " " + wrestler.last_name, wrestler.school, wrestler.abbreviation, wrestler.grade, wrestler.wins, wrestler.losses, wrestler.seed, wrestler.section_place, wrestler.state_place, wrestler.comments ]
      end
    end
  end

  def self.to_csv2(options = {})

    CSV.generate(options) do |csv|
      csv << ["Weight", "league place", "school", "full name", "grade", "wins", "losses", "section place", "state place", "tournament 1", "tournament 2", "tournament 3", "tournament 4", "tournament 5", "h2h 1", "h2h 2", "h2h 3", "h2h 4", "h2h 5"]
      all.each do |wrestler|
        csv << [wrestler.weight, wrestler.league_place, wrestler.school.name, wrestler.first_name + " " + wrestler.last_name, wrestler.grade, wrestler.wins, wrestler.losses, wrestler.section_place, wrestler.state_place, wrestler.t1_name , wrestler.t2_name  , wrestler.t3_name   , wrestler.t4_name  , wrestler.t5_name  , wrestler.h2h_1 , wrestler.h2h_2 , wrestler.h2h_3 , wrestler.h2h_4 , wrestler.h2h_5  ]
      end
    end
  end
end