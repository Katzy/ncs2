class Wrestler < ActiveRecord::Base

  belongs_to :school
  belongs_to :league
  has_many :bouts

  validates :first_name, presence: true, null: false
  validates :last_name, presence: true, null: false
  validates :weight, presence: true, null: false
  validates :school_id, presence: true, null: false
 
  # validates_uniqueness_of :weight, scope: :school_id
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
       # if Wrestler.find()
      Wrestler.create! row.to_hash
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["weight", "first name", "last name", "league", "school", "abbreviation", "grade", "wins", "losses", "SEED", "LEAGUE PL", "SEC", "ST"]

      all.each do |wrestler|
       csv << [wrestler.weight, wrestler.first_name, wrestler.last_name, wrestler.school.league.name, wrestler.school.name, wrestler.school.abbreviation, wrestler.grade, wrestler.wins, wrestler.losses, wrestler.seed, wrestler.league_place, wrestler.section_place, wrestler.state_place]
      end
    end
  end

  def self.to_csv2(options = {})

    CSV.generate(options) do |csv|
      csv << ["Seed", "Weight", "league place", "league", "school", "full name", "grade", "wins", "losses", "section place", "state place", "T1", "T1 PLACE", "T2", "T2 PLACE", "T3", "T3 PLACE", "T4", "T4 PLACE", "T5", "T5 PLACE", "h2h 1", "h2h 1R", "h2h 2", "h2h 2R", "h2h 3", "h2h 3R", "h2h 4", "h2h 4R", "h2h 5", "h2h 5R"]
      all.each do |wrestler|
        csv << [wrestler.seed, wrestler.weight, wrestler.league_place, wrestler.school.league.name, wrestler.school.name, wrestler.first_name + " " + wrestler.last_name, wrestler.grade, wrestler.wins, wrestler.losses, wrestler.section_place, wrestler.state_place, wrestler.t1_name, wrestler.t1_place, wrestler.t2_name, wrestler.t2_place, wrestler.t3_name, wrestler.t3_place, wrestler.t4_name, wrestler.t4_place, wrestler.t5_name, wrestler.t5_place, wrestler.h2h_1, wrestler.h2h_r1, wrestler.h2h_2, wrestler.h2h_r2, wrestler.h2h_3, wrestler.h2h_r3,  wrestler.h2h_4, wrestler.h2h_r4, wrestler.h2h_5, wrestler.h2h_r5 ]
      end
    end
  end
end