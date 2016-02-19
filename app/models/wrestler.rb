class Wrestler < ActiveRecord::Base

  belongs_to :school

  validates :first_name, presence: true, null: false
  validates :last_name, presence: true, null: false
  validates :weight, presence: true, null: false
  validates :school_id, presence: true, null: false
  # validates :losses, presence: true, null: false
  # validates :grade, presence: true, null: false
  validates_uniqueness_of :weight, scope: :school_id

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["weight", "full name", "school", "abbreviation", "grade", "wins", "losses", "SEED", "SEC", "ST", "Comments"]

      all.each do |wrestler|
       csv << [wrestler.weight, wrestler.first_name + " " + wrestler.last_name, wrestler.school, wrestler.abbreviation, wrestler.grade, wrestler.wins, wrestler.losses, wrestler.seed, wrestler.section_place, wrestler.state_place, wrestler.comments ]
      end
    end
  end

  def self.to_csv2(options = {}, tournaments)

    CSV.generate(options) do |csv|
      csv << ["Weight", "full name", "abbreviation", "grade", "wins", "losses", "section place", "state place", tournaments[0], tournaments[1], tournaments[2], tournaments[3], tournaments[4], tournaments[5], tournaments[6], tournaments[7], "comments"]
      all.each do |wrestler|
        csv << [wrestler.weight, wrestler.first_name + " " + wrestler.last_name, wrestler.abbreviation, wrestler.grade, wrestler.wins, wrestler.losses, wrestler.section_place, wrestler.state_place, wrestler.t1_place, wrestler.t2_place, wrestler.t3_place, wrestler.t4_place, wrestler.t5_place, wrestler.t6_place, wrestler.t7_place, wrestler.t8_place, wrestler.comments ]
      end
    end
  end
end