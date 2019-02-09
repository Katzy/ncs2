class WrestlersController < ApplicationController
  # before_action :load_league, only: [:new, :create]
  before_filter :authorize_user, :only => [:new, :create, :edit, :update]
  def index
     @wrestlers = Season.last.wrestlers.where(tourney_team: true).where.not(school_id: 123).where.not(school_id: 125).where.not(school_id: 125).order('weight ASC, state_place ASC, section_place ASC, seed ASC, win_tally DESC')
    # @wrestlers = Wrestler.order('weight ASC, state_place ASC, section_place ASC, seed ASC, wins DESC')
    wrestlers = @wrestlers
    if params[:season_id]
      @season = Season.find(params[:season_id])
    else
      @season = Season.last
    end
    @user = current_user
    @count = @wrestlers.count
    @tourney_results = []

    respond_to do |format|
      format.html
      format.csv { send_data wrestlers.to_csv }
      format.xls { send_data wrestlers.to_csv({col_sep: "\t"})}

    end
  end

  def new

    @wrestler = Wrestler.new
    @tournaments = Tournament.order('name ASC')
  end

  def create
    @school = School.find(wrestler_params[:school_id])

    @wrestler = @school.wrestlers.new(wrestler_params)
    # @wrestler.alternate == 0 ? @wrestler.alternate = false : @wrestler.alternate
    @league = League.find(@school.league_id)
    @wrestler.league_id = @league.id
    # @wrestler.season_id = Season.last.id
    # @tournaments = Tournament.order('name ASC')
    user = current_user
    wrestler = @wrestler
    wrestler_array = [user, wrestler]
    @wrestler.fullname = wrestler_params[:first_name] + " " + wrestler_params[:last_name]

    respond_to do |format|
      if @wrestler.save
      SeasonWrestler.create({season_id: Season.last.id, wrestler_id: Wrestler.last.id, wrestler_school_id: Wrestler.last.school.id})
       UserMailer.wrestler_added(wrestler_array).deliver
        format.html { redirect_to school_wrestlers_path(@school, season_id: Season.last.id), notice: 'wrestler was successfully created.' }
         format.json { render json: @wrestler.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @wrestler.errors, status: :unprocessable_entity }
      else
        load_league
        format.html { render action: 'new' }
        format.json { render json: @wrestler.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @wrestler.errors, status: :unprocessable_entity }
      end
    end

  end

  def autocomplete 
    query = params[:query].downcase
    @graplers = Wrestler.where("lower(fullname) LIKE ?", "%#{query}%")
    render json: { graplers: @graplers.present_name_weight_school }
  end

  def edit
    @wrestler = Wrestler.find(params[:id])
    @tourney_results = []
    uid = @wrestler.school_id
    @school = School.find(@wrestler.school_id)
    @league = League.find(@school.league_id)
    @tournaments = Tournament.all
    p @league.name

  end

  def weight_106
    @wt = 106
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_113
    @wt = 113
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_120
    @wt = 120
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_126
    @wt = 126
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_132
    @wt = 132
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_138
    @wt = 138
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_145
    @wt = 145
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_152
    @wt = 152
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_160
    @wt = 160
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_170
    @wt = 170
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_182
    @wt = 182
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_195
    @wt = 195
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_220
    @wt = 220
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def weight_285
    @wt = 285
    @tourney_results = []
    select_wrestlers(@wt)
  end

  def alternates
    if params[:weight]
    @wrestlers = Season.last.wrestlers.where('league_place LIKE ?', '%LT-%').where(weight: params[:weight]).order('weight ASC, league_place ASC')
    else
      @wrestlers = Season.last.wrestlers.where('league_place LIKE ?', '%LT-%').order('weight ASC, league_place ASC')
    end
  end

  def compare
    # @wrestlers = []
    @wrestlers = Wrestler.where(weight: params[:weight], tourney_team: true, season_id: Season.last.id).where.not(league_place: nil, league_place: "").order('last_name ASC')
    # @wr.each do |w|
      # @wrestler = Wrestler.new
      # @wrestler.first_name = w["first_name"]
      # @wrestler.last_name = w["last_name"]
      # @wrestler.weight = w["weight"]
      # # @wrestler.wins = w["wins"]
      # # @wrestler.losses = w["losses"]
      # @wrestler.grade = w["grade"]
      # # @wrestler.league_place = w["league_place"]
      # # @wrestler.section_place = w["section_place"]
      # # @wrestler.state_place = w["state_place"]
      # @wrestler.school_id = w["school_id"]
      # # @wrestler.season_id = w["season_id"]
      # # @wrestler.t1_name = w["t1_name"]
      # # @wrestler.t1_place = w["t1_place"]
      # # @wrestler.t2_name = w["t2_name"]
      # # @wrestler.t2_place = w["t2_place"]
      # # @wrestler.t3_name = w["t3_name"]
      # # @wrestler.t3_place = w["t3_place"]
      # # @wrestler.t4_name = w["t4_name"]
      # # @wrestler.t4_place = w["t4_place"]
      # # @wrestler.t5_name = w["t5_name"]
      # # @wrestler.t5_place = w["t5_place"]
      # @wrestlers << @wrestler
      # @wrestlers << w
    # end
    # respond_to do |format|
    #   format.html { render :compare }
      # format.js 
    # end
  end

  def compare_selected
    @wr = []
      @tourney_results = []

    if params[:wrestlers]
      params[:wrestlers].each do |k,v|
      
        if v["checked"] == "1"
          @wr << Wrestler.where(first_name: v["first_name"], last_name: v["last_name"], weight: v["weight"], school_id: v["school_id"], season_id: Season.last.id)[0] 
          @weight = v["weight"] 
        end
      end
    end
    params.delete :wrestlers
    @count = @wr.count

        redirect_to show_compared_wrestlers_path(wrestlers: @wr)
      # if @wrestlers.count > 0
      #   redirect_to user_wrestlers_path(User.find(params[:user_id])), notice: "Import successful!"
      #   UserMailer.team_imported(@user, @wrestlers).deliver
      # else
      #   redirect_to user_wrestlers_path(User.find(params[:user_id])), notice: "Import did not happen!  Did you forget to check off wrestlers?"  
      # end
      
  end

  def show_compared
    @comparing = true
    @wr = params[:wrestlers]
    @wrestlers = []
    @wr.each do |w|
      @wrestlers << Wrestler.find(w)
    end
    @wrestlers = @wrestlers.sort_by{|k| k["wins"]}
    @count = @wr.count
    @tourney_results = []
    @weight = @wrestlers[0].weight    
  end

  def show
    # @season = Season.find(params[:season_id])
    @wrestler = Wrestler.find(params[:id])
    @season_wrestler = SeasonWrestler.where(wrestler_id: params[:id])
    # @wrestler = @season.wrestlers.find(params[:id])
    
    @season = Season.find(@season_wrestler[0].season_id)
    wrestler = @wrestler
    @bouts = @wrestler.bouts.order('id ASC')
    @match_number = 1
    @count = 1
    @tourney_results = []
    wrestler.bouts.each do |bout| 
      if bout.tourney_place && bout.tourney_place > 0 
        unless @tourney_results.include?([bout.tourney_name, bout.tourney_place]) 
          @tourney_results << [bout.tourney_name, bout.tourney_place] 
        end 
      end 
    end 
    if wrestler.t1_name != "" && wrestler.t1_name != nil && wrestler.t1_name != " " 
     @tourney_results << [ wrestler.t1_name, wrestler.t1_place] 
   end 
   if wrestler.t2_name != "" && wrestler.t2_name != nil && wrestler.t2_name != " " 
     @tourney_results << [ wrestler.t2_name, wrestler.t2_place] 
   end 
   if wrestler.t3_name != "" && wrestler.t3_name != nil && wrestler.t3_name != " " 
     @tourney_results << [ wrestler.t3_name, wrestler.t3_place] 
   end 
   if wrestler.t4_name != "" && wrestler.t4_name != nil && wrestler.t4_name != " " 
     @tourney_results << [ wrestler.t4_name, wrestler.t4_place] 
   end 
   if wrestler.t5_name != "" && wrestler.t5_name != nil && wrestler.t5_name != " " 
     @tourney_results << [ wrestler.t5_name, wrestler.t5_place] 
   end
    @full_name = @wrestler.first_name + ' ' + @wrestler.last_name
    respond_to do |format|
      format.html { render :show }
      format.pdf do
        render pdf: "#{@wrestler.first_name}_#{@wrestler.last_name}_#{@wrestler.weight}.pdf",
               layout: "wrestler_pdf", 
               template: "wrestlers/show.pdf.erb",
               locals: { :wrestler => @wrestler },
               orientation: "Landscape"
      end
    end
  end

  def update

    @wrestler = Wrestler.find(params[:id])
    @season_id = SeasonWrestler.where(wrestler_id: @wrestler.id)[0].season_id
    weight = @wrestler.weight
    user = current_user
    wrestler = @wrestler
    @school = School.find(@wrestler.school_id)
    @league = @school.league_id
    wrestler_array = [user, wrestler]
    if @wrestler.update(wrestler_params)
       UserMailer.wrestler_updated(wrestler_array).deliver
      if current_user.admin?
        if weight == 106
          redirect_to wrestlers_weight_106_path
        elsif weight == 113
          redirect_to wrestlers_weight_113_path
        elsif weight == 120
          redirect_to wrestlers_weight_120_path
        elsif weight == 126
          redirect_to wrestlers_weight_126_path
        elsif weight == 132
          redirect_to wrestlers_weight_132_path
        elsif weight == 138
          redirect_to wrestlers_weight_138_path
        elsif weight == 145
          redirect_to wrestlers_weight_145_path
        elsif weight == 152
          redirect_to wrestlers_weight_152_path
        elsif weight == 160
          redirect_to wrestlers_weight_160_path
        elsif weight == 170
          redirect_to wrestlers_weight_170_path
        elsif weight == 182
          redirect_to wrestlers_weight_182_path
        elsif weight == 195
          redirect_to wrestlers_weight_195_path
        elsif weight == 220
          redirect_to wrestlers_weight_220_path
        elsif weight == 285
          redirect_to wrestlers_weight_285_path
        end
      else
        redirect_to school_wrestlers_path(@wrestler.school, season_id: @season_id)
      end
    else
      render :edit
    end
  end

  def destroy_all
    Wrestler.delete_all
    respond_to do |format|
      format.html { redirect_to wrestlers_path }
      format.json { head :no_content }
    end
  end


  def destroy
    user = current_user
    @wrestler = Wrestler.find(params[:id])
    wrestler = @wrestler
    wrestler_array = [user, wrestler]
    @wrestler.destroy
    # UserMailer.wrestler_deleted(wrestler_array).deliver
    redirect_to :back
  end

  def generate_bracket
    @bp = ["1 SEED-1", "3rd -2", "2nd -3", "4th or WC -4", "2nd -5", "2nd or 1 -6", "2nd -7", "3rd -8", "3rd or 2nd -9", "8 SEED -10", "5 SEED -11", "3rd -12", "2nd -13", "4th or WC -14", "1st or 2nd -15", "2nd or 1st -16", "2nd -17", "3rd -18", "3rd -19", "4 SEED -20", "3 SEED -21", "3rd -22", "2nd -23", "4th or WC -24", "1st or 2nd -25", "2nd or 1st -26", "2nd -27", "3rd -28", "3rd or 2nd -29", "6 SEED -30", "7 SEED -31", "3rd -32", "2nd -33", "4th or WC -34", "1st or 2nd -35", "2nd or 1st -36", "2nd -37", "3rd -38", "3rd -39", "2 SEED -40"]
    puts @bp
  end

  private

  
  # def check_bracket_validity(wrestlers)
  #   temp_bracket = []
  #     if wrestlers[0][0] == 1
  #       temp_bracket[0] = wrestlers[0]
  #       wrestlers.shift
  #     end
  #     if wrestlers[0][0] == 2
  #       temp_bracket[39] = wrestlers[0]
  #       wrestlers.shift
  #     end
  #     if wrestlers[0][0] == 3
  #       temp_bracket[20] = wrestlers[0]
  #       wrestlers.shift 
  #     end
  #     if wrestlers[0][0] == 4
  #       temp_bracket[19] = wrestlers[0]
  #       wrestlers.shift
  #     end
  #     if wrestlers[0][0] == 5
  #       temp_bracket[10] = wrestlers[0]
  #       wrestlers.shift
  #     end
  #     if wrestlers[0][0] == 6
  #       temp_bracket[29] = wrestlers[0]
  #       wrestlers.shift
  #     end
  #     if wrestlers[0][0] == 7
  #       temp_bracket[30] = wrestlers[0]
  #       wrestlers.shift 
  #     end
  #     if wrestlers[0][0] == 8
  #       temp_bracket[9] = wrestlers[0]
  #       wrestlers.shift
  #     end
  #     if wrestlers[0][0] == 9
  #       temp_bracket[5] = wrestlers[0]
  #       wrestlers.shift
  #     end
  #     if wrestlers[0][0] == 10
  #       temp_bracket[34] = wrestlers[0]
  #       wrestlers.shift
  #     end



  #     for i in 0..(wrestlers.size-1)
  #       until wrestler[i][0] == nil 
  #         if wrestler[i][0] == 1
  #           temp_bracket[0] = wrestler[i]
  #         end
  #         if wrestler[i][0] == 2
  #           temp_bracket[39] = wrestler[i]
  #         end
  #         if wrestler[i][0] == 3
  #           temp_bracket[20] = wrestler[i]
  #         end
  #         if wrestler[i][0] == 4
  #           temp

  #     end
  # end


  def load_league
    #get product_type from session if it is blank
    params[:league_id] ||= session[:league_id]
    #save product_type to session for future requests
    session[:league_id] = params[:league_id]
    if params[:league_id]
      @league = League.find(params[:league_id])

    end
  end


  def select_wrestlers(wt)
      @comparing = false
      params = ["1","2","3","4","5", true]
      @season = Season.last
      @w = @season.wrestlers.where(weight: wt).where.not(league_place: nil, league_place: "")
      # @w = @season.wrestlers.where(weight: wt, tourney_team: true).where.not(league_place: "")
      # @wrestlers = @w.where("league_place = ? OR league_place = ? OR league_place = ? OR league_place = ? OR league_place = ? OR alternate = ?", *params).order('weight ASC, seed ASC, state_place ASC, section_place ASC, seed ASC, wins DESC')
      @wrestlers = @w.order('seed ASC, state_place ASC, section_place ASC, league_place ASC, wins DESC')
      # wrestlers = @wrestlers 
      # Wrestler.where("weight = #{wt}").order('weight ASC, seed ASC, wins DESC')  # for csv format
      @tourney_results = []

      @count2 = @wrestlers.count
      @wins = []
      @losses = []
    respond_to do |format|
      format.html
      format.csv { send_data wrestlers.to_csv2 }
      format.xls { send_data wrestlers.to_csv2({col_sep: "\t"})}

    end
  end
  def wrestlers_params
    params.permit({:wrestler[:id] => [:checked, :weight, :id]})
  end

  def wrestler_params
    params.require(:wrestler).permit(:first_name, :abbreviation, :school, :league_id, :league, :last_name, :weight, :grade, :wins, :losses, :tourney_wins, :league_place, :section_place, :state_place, :seed, :comments, :school_id, :t1_name, :t1_place, :t2_name, :t2_place, :t3_name, :t3_place, :t4_name, :t4_place, :t5_name, :t5_place, :t6_name, :t6_place, :t7_name, :t7_place, :t8_name, :t8_place, :h2h_1, :h2h_r1, :h2h_2, :h2h_r2, :h2h_3, :h2h_r3, :h2h_4, :h2h_r4, :h2h_5, :h2h_r5, :alternate, :fullname, :scratch, :tourney_team, :league_1ya, :losses_ncs, :gender, :season_id, :checked)
  end

end