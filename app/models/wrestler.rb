class Wrestler < ActiveRecord::Base
  acts_as_xlsx

  belongs_to :league
  belongs_to :school
  has_many :bouts

  validates :first_name, presence: true, null: false
  validates :last_name, presence: true, null: false
  validates :weight, presence: true, null: false
  validates :school_id, presence: true, null: false
  validates :wins, presence: true, null: false
  validates :losses, presence: true, null: false
  # validates_uniqueness_of :weight, scope: :school_id
  def self.present_all
    self.all.map { |item| item.present }
  end

  def self.present_name_weight_school
    a = self.all.map { |item| item.name_weight_school }
    puts a
    a
  end

  def name_weight_school
    { 
      fullname: fullname,
      school: self.school.name,
      description: self.school.name
    }
  end

  def present
    { weight: weight,
      id: id,
      first_name: first_name,
      last_name: last_name,
      school_id: school_id,
      league_id: league_id,
      grade: grade,
      wins: wins,
      losses: losses,
      seed: seed,
      league_place: league_place,
      section_place: section_place,
      state_place: state_place
    }
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      if Wrestler.exists?(first_name: row[3], last_name: row[4], grade: row[1])
        row
      else
        Wrestler.create! row.to_hash
      end
    end
  end

  def self.import(file, school)
    CSV.foreach(file.path, headers: true) do |row|
      if row[4] == nil || row[4] == "" 
        row
      elsif Wrestler.exists?(last_name: row[3], first_name: row[2], weight: row[0])
        row
      else
        row[1] = school
        row[2] = row[2].downcase.capitalize
        row[3] = row[3].downcase.capitalize
        p row
        School.find(school.id).wrestlers.create! row.to_hash
      end
    end
  end

    def self.download(school)
    CSV.generate do |csv|
      csv << ["weight", "school", "first_name", "last_name", "grade", "wins", "losses", "section_place", "state_place", "t1_name", "t1_place", "t2_name", "t2_place", "t3_name", "t3_place", "t4_name", "t4_place", "t5_name", "t5_place"]
      csv << [ "106", school.name]
      csv << [ "113", school.name ]
      csv << [ "120", school.name ]
      csv << [ "126", school.name ]
      csv << [ "132", school.name ]
      csv << [ "138", school.name ]
      csv << [ "145", school.name ]
      csv << [ "152", school.name ]
      csv << [ "160", school.name ]
      csv << [ "170", school.name ]
      csv << [ "182", school.name ]
      csv << [ "195", school.name ]
      csv << [ "220", school.name ]
      csv << [ "285", school.name ]      
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
      csv << ["Weight", "first_name", "last_name", "league place", "league", "school", "full name", "grade", "wins", "losses", "section place", "state place", "T1", "T1 PLACE", "T2", "T2 PLACE", "T3", "T3 PLACE", "T4", "T4 PLACE", "T5", "T5 PLACE", "h2h 1", "h2h 1R", "h2h 2", "h2h 2R", "h2h 3", "h2h 3R", "h2h 4", "h2h 4R", "h2h 5", "h2h 5R"]
      all.each do |wrestler|
        csv << [wrestler.seed, wrestler.weight, wrestler.league_place, wrestler.school.league.name, wrestler.school.name, wrestler.first_name + " " + wrestler.last_name, wrestler.grade, wrestler.wins, wrestler.losses, wrestler.section_place, wrestler.state_place, wrestler.t1_name, wrestler.t1_place, wrestler.t2_name, wrestler.t2_place, wrestler.t3_name, wrestler.t3_place, wrestler.t4_name, wrestler.t4_place, wrestler.t5_name, wrestler.t5_place, wrestler.h2h_1, wrestler.h2h_r1, wrestler.h2h_2, wrestler.h2h_r2, wrestler.h2h_3, wrestler.h2h_r3,  wrestler.h2h_4, wrestler.h2h_r4, wrestler.h2h_5, wrestler.h2h_r5 ]
      end
    end
  end
end