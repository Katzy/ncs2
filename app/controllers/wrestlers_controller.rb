class WrestlersController < ApplicationController
  # before_action :load_league, only: [:new, :create]
  before_filter :authorize_user, :only => [:new, :create, :edit, :update]
  def index
     @wrestlers = Season.last.wrestlers.where(tourney_team: true).where.not(league_place: "").order('weight ASC, state_place ASC, section_place ASC, seed ASC, win_tally DESC')
    # @wrestlers = Wrestler.order('weight ASC, state_place ASC, section_place ASC, seed ASC, wins DESC')
    wrestlers = @wrestlers

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
    @wrestlers = Season.last.wrestlers.where('league_place LIKE ?', '%LT-%').order('weight ASC, league_place ASC')
  end

  def compare
    @wrestlers = []
    @wr = Season.last.wrestlers.where(weight: params[:weight]).where('league_id IS NOT null')
    @wr.each do |w|
      @wrestler = Wrestler.new
      @wrestler.first_name = w["first_name"]
      @wrestler.last_name = w["last_name"]
      @wrestler.weight = w["weight"]
      @wrestler.wins = w["wins"]
      @wrestler.losses = w["losses"]
      @wrestler.grade = w["grade"]
      @wrestler.league_place = w["league_place"]
      @wrestler.section_place = w["section_place"]
      @wrestler.state_place = w["state_place"]
      @wrestler.school_id = w["school_id"]
      @wrestler.season_id = w["season_id"]
      @wrestler.t1_name = w["t1_name"]
      @wrestler.t1_place = w["t1_place"]
      @wrestler.t2_name = w["t2_name"]
      @wrestler.t2_place = w["t2_place"]
      @wrestler.t3_name = w["t3_name"]
      @wrestler.t3_place = w["t3_place"]
      @wrestler.t4_name = w["t4_name"]
      @wrestler.t4_place = w["t4_place"]
      @wrestler.t5_name = w["t5_name"]
      @wrestler.t5_place = w["t5_place"]
      @wrestlers << @wrestler
    end
    respond_to do |format|
      format.html { render :compare }
      # format.js 
    end
  end

  def compare_selected
    @wr = params[:wrestlers]
    @wrestlers = []
    @wr.each do |w|
      @tourney_results = []
      if w["checked"] == "1"
        @wrestlers << Wrestler.where(first_name: w["first_name"], last_name: w["last_name"], weight: w["weight"], school_id: w["school_id"])[0] 
        @weight = w["weight"] 
     end
    end
      if @wrestlers.count > 0
        show_compared(@wrestlers)
      end
      # if @wrestlers.count > 0
      #   redirect_to user_wrestlers_path(User.find(params[:user_id])), notice: "Import successful!"
      #   UserMailer.team_imported(@user, @wrestlers).deliver
      # else
      #   redirect_to user_wrestlers_path(User.find(params[:user_id])), notice: "Import did not happen!  Did you forget to check off wrestlers?"  
      # end
      
  end

  def show_compared(wrestlers)
    @w = wrestlers
    @wrestlers = []
    @count = @w.count
    @w.each do |wr|
      @wrestlers << Wrestler.find(wr)
    end
    render { :compare_selected }
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
               locals: { :wrestler => wrestler },
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

  private

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
      params = ["1","2","3","4","5", true]
      @season = Season.last
      @w = @season.wrestlers.where(weight: wt, tourney_team: true).where('league_id IS NOT null')
      # @w = @season.wrestlers.where(weight: wt, tourney_team: true).where.not(league_place: "")
      # @wrestlers = @w.where("league_place = ? OR league_place = ? OR league_place = ? OR league_place = ? OR league_place = ? OR alternate = ?", *params).order('weight ASC, seed ASC, state_place ASC, section_place ASC, seed ASC, wins DESC')
      @wrestlers = @w.order('seed ASC, state_place ASC, section_place ASC, win_tally DESC')
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
    params.require(:wrestlers).permit({:id => [:checked, :weight, :id]})
  end

  def wrestler_params
    params.require(:wrestler).permit(:first_name, :abbreviation, :school, :league_id, :league, :last_name, :weight, :grade, :wins, :losses, :tourney_wins, :league_place, :section_place, :state_place, :seed, :comments, :school_id, :t1_name, :t1_place, :t2_name, :t2_place, :t3_name, :t3_place, :t4_name, :t4_place, :t5_name, :t5_place, :t6_name, :t6_place, :h2h_1, :h2h_r1, :h2h_2, :h2h_r2, :h2h_3, :h2h_r3, :h2h_4, :h2h_r4, :h2h_5, :h2h_r5, :alternate, :fullname, :scratch, :tourney_team, :league_1ya, :losses_ncs, :gender, :season_id, :checked)
  end

end