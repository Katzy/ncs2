class Wrestler < ActiveRecord::Base
  acts_as_xlsx

  belongs_to :league
  belongs_to :school
  belongs_to :season
  has_many :season_wrestlers
  has_many :bouts

  validates :first_name, presence: true, null: false
  validates :last_name, presence: true, null: false
  validates :weight, presence: true, null: false
  validates :school_id, presence: true, null: false
  # validates :wins, presence: true, null: false
  # validates :losses, presence: true, null: false
  # validates_uniqueness_of :tourney_team, scope: [:school_id, :weight], if: 'tourney_team == true', :message => ":  You already designated a wrestler at this weight to be on your tournament team.  Only 1 is allowed per weight!"


  def self.present_all
    self.all.map { |item| item.present }
  end

  def self.present_name_weight_school
    a = self.all.map { |item| item.name_weight_school }
    puts a
    a
  end

  # def has_tourney_team
  #   exists.where(school_id: school_id).where(weight: weight).where(tourney_team: true)
  # end
    
 

  def name_weight_school
    { 
      fullname: fullname,
      school: self.school.name,
      description: self.school.name
    }
  end

  def present
    @tourney_results = []
    self.bouts.each do |bout| 
      if bout.tourney_place && bout.tourney_place > 0 
        unless @tourney_results.include?([bout.tourney_name, bout.tourney_place]) 
          @tourney_results << [bout.tourney_name, bout.tourney_place] 
        end 
      end 
    end 
    { weight: weight,
      id: id,
      first_name: first_name,
      last_name: last_name,
      school_id: school_id,
      league_id: league_id,
      grade: grade,
      wins: self.bouts.where(win_loss: "W").count,
      losses: self.bouts.where(win_loss: "L").count,
      seed: seed,
      league_place: league_place,
      section_place: section_place,
      state_place: state_place,
      t1_name: @tourney_results[0] != nil ? @tourney_results[0][0] : nil,
      t1_place: @tourney_results[0] != nil ? @tourney_results[0][1] : nil,
      t2_name: @tourney_results[1] != nil ? @tourney_results[1][0] : nil,
      t2_place: @tourney_results[1] != nil ? @tourney_results[1][1] : nil,
      t3_name: @tourney_results[2] != nil ? @tourney_results[2][0] : nil,
      t3_place: @tourney_results[2] != nil ? @tourney_results[2][1] : nil,
      t4_name: @tourney_results[3] != nil ? @tourney_results[3][0] : nil,
      t4_place: @tourney_results[3] != nil ? @tourney_results[3][1] : nil,
      t5_name: @tourney_results[4] != nil ? @tourney_results[4][0] : nil,
      t5_place: @tourney_results[4] != nil ? @tourney_results[4][1] : nil
    }
  end


   

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      if Wrestler.exists?(first_name: row[3], last_name: row[4], grade: row[1])
        row
      else
        Wrestler.create! row.to_hash
        SeasonWrestler.create({season_id: Season.last.id, wrestler_id: Wrestler.last.id, wrestler_school_id: Wrestler.last.school.id})
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
       
        School.find(school.id).wrestlers.create! row.to_hash
          SeasonWrestler.create({season_id: Season.last.id, wrestler_id: Wrestler.last.id, wrestler_school_id: Wrestler.last.school.id})
      end
    end
  end



    def self.download(school)
    CSV.generate do |csv|
      csv << ["weight", "school", "first_name", "last_name", "grade", "wins", "losses"]
      # , "wins", "losses", "section_place", "state_place", "t1_name", "t1_place", "t2_name", "t2_place", "t3_name", "t3_place", "t4_name", "t4_place", "t5_name", "t5_place"
      csv << [ "106", school.name]
      csv << [ "106", school.name]
      csv << [ "106", school.name]
      csv << [ "106", school.name]
      csv << [ "113", school.name ]
      csv << [ "113", school.name ]
      csv << [ "113", school.name ] 
      csv << [ "120", school.name ]
      csv << [ "120", school.name ]
      csv << [ "120", school.name ]
      csv << [ "126", school.name ]
      csv << [ "126", school.name ]
      csv << [ "126", school.name ]
      csv << [ "132", school.name ]
      csv << [ "132", school.name ]
      csv << [ "132", school.name ]
      csv << [ "138", school.name ]
      csv << [ "138", school.name ]
      csv << [ "138", school.name ]
      csv << [ "145", school.name ]
      csv << [ "145", school.name ]
      csv << [ "145", school.name ]
      csv << [ "152", school.name ]
      csv << [ "152", school.name ]
      csv << [ "152", school.name ]
      csv << [ "160", school.name ]
      csv << [ "160", school.name ]
      csv << [ "160", school.name ]
      csv << [ "170", school.name ]
      csv << [ "170", school.name ]
      csv << [ "170", school.name ]
      csv << [ "182", school.name ]
      csv << [ "182", school.name ]
      csv << [ "182", school.name ]
      csv << [ "195", school.name ]
      csv << [ "195", school.name ]
      csv << [ "195", school.name ]
      csv << [ "220", school.name ]
      csv << [ "220", school.name ]
      csv << [ "220", school.name ]
      csv << [ "285", school.name ]
      csv << [ "285", school.name ]
      csv << [ "285", school.name ]      
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["weight", "first name", "last name", "league", "school", "abbreviation", "grade", "wins", "losses", "SEED", "AT LARGE", "LEAGUE PL", "SEC", "ST"]

      all.each do |wrestler|
       csv << [wrestler.weight, wrestler.first_name, wrestler.last_name, wrestler.school.league.name, wrestler.school.name, wrestler.school.abbreviation, wrestler.grade, (wrestler.wins + wrestler.bouts.where(win_loss: "W").count), (wrestler.losses + wrestler.bouts.where(win_loss: "L").count), wrestler.seed, (wrestler.alternate if wrestler.alternate == true), wrestler.league_place, wrestler.section_place, wrestler.state_place]
      end
    end
  end

    def self.to_csv3(options = {}, teams, wrestlers)
    CSV.generate(options) do |csv|
      # csv << ["weight", "full name", "abbreviation", "grade", "wins", "losses", "Comments"]
      teams.each do |team|
        csv << ["t", team.name, team.abbreviation]
      end
      all.each do |wrestler|
        
         if wrestler.bouts.where(win_loss: "W").count && (wrestler.wins >= 0 if wrestler.wins != nil)
            wins = (wrestler.bouts.where(win_loss: "W").count + wrestler.wins)
            losses = (wrestler.bouts.where(win_loss: "L").count + wrestler.losses)
        else
          wins = wrestler.wins
          losses = wrestler.losses 
        end 

        csv << ["w", wrestler.weight, wrestler.first_name + " " + wrestler.last_name, wrestler.school.abbreviation, wrestler.grade, wins, losses ]
      end
    end
  end

  def self.to_csv2(options = {})
    
    CSV.generate(options) do |csv|
      
      csv << ["weight", "school", "first_name", "last_name", "grade", "wins", "losses", "section_place(Last year)", "state_place(last year)", "t1_name", "t1_place", "t2_name", "t2_place", "t3_name", "t3_place", "t4_name", "t4_place", "t5_name", "t5_place"]
      all.each do |wrestler|
        tourney_array = []
        if wrestler.bouts
          wrestler.bouts.each do |bout|
            if bout.tourney_place && bout.tourney_place > 0
              unless tourney_array.include?([bout.tourney_name, bout.tourney_place])
                tourney_array << [bout.tourney_name, bout.tourney_place]
              end
            end
          end
        end
        until tourney_array.count == 12
          tourney_array << " "
        end
        #  if wrestler.bouts.where(win_loss: "W").count && (wrestler.wins >= 0 if wrestler.wins != nil)
        #     wins = (wrestler.bouts.where(win_loss: "W").count + wrestler.wins)
        #     losses = (wrestler.bouts.where(win_loss: "L").count + wrestler.losses)
        # else
        #   wins = wrestler.wins
        #   losses = wrestler.losses 
        # end 
        csv << [wrestler.weight, wrestler.school.name, wrestler.first_name, wrestler.last_name, wrestler.grade, (wrestler.bouts.where(win_loss: "W").count), (wrestler.bouts.where(win_loss: "L").count), wrestler.section_place, wrestler.state_place, tourney_array[0][0], tourney_array[0][1], tourney_array[1][0], tourney_array[1][1], tourney_array[2][0], tourney_array[2][1], tourney_array[3][0], tourney_array[3][1], tourney_array[4][0], tourney_array[4][1]]
      end
    end
  end

end