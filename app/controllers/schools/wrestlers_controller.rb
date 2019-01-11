module Schools
  class WrestlersController < ApplicationController
   before_action :load_league, only: [:new, :index, :create]
   before_filter :authorize_user, :only => [:new, :create, :edit, :update]
    def index

       @school = School.find(params[:school_id])
       if @school.league_id
        @lg = League.find(@school.league_id)
      end
      @seasons = Season.all.order('id DESC')
       @season = Season.find(params[:season_id])
        if SeasonWrestler.where(season_id: @season.id, wrestler_school_id: @school.id).count > 0 
          @wrestlers = @season.wrestlers.where(school_id: @school.id).order('tourney_team DESC, weight ASC')
        else
          @wrestlers = []
        end
        wrestlers = @wrestlers
        @tourney_results = []
      @user = current_user
      @count = @wrestlers.count
      @wins = []
      @losses = []
      @tourneys = []
      respond_to do |format|
        format.html
        format.csv { send_data wrestlers.to_csv2, filename: @school.name + '_wrestlers.csv'}

      end
    end

    def tourney_team
      @school = School.find(params[:school_id])
      @season = Season.find(params[:season_id])
      if SeasonWrestler.where(season_id: @season.id, wrestler_school_id: @school.id).count > 0 
        @wrestlers = @season.wrestlers.where(school_id: @school.id, tourney_team: true).order('weight ASC')
      else
        @wrestlers = []
      end
      wrestlers = @wrestlers
      respond_to do |format|
        format.html
        format.csv { send_data wrestlers.to_csv2, filename: @school.name + '_tournament_wrestlers.csv'}
      end
    end

    def download
      school = School.find(params[:school_id])
      respond_to do |format|
        format.html
        format.csv { send_data Wrestler.download(school), filename: school.name + '_import_file' + '.csv' }
      end
    end

    def help
      @school = School.find(params[:school_id])
    end

    def import
      user = current_user
      school = School.find(params[:school_id])
      @season = Season.last
      if params[:file] != nil
        School.find(params[:school_id]).wrestlers.import(params[:file], school)
        wrestlers = Season.last.wrestlers.where(school_id: school.id).order('weight ASC')
        wrestler_array = [user, wrestlers]
        UserMailer.team_upload(wrestler_array).deliver
        redirect_to school_wrestlers_path(school, season_id: @season.id), notice: "Import successful!"
      else
        redirect_to school_wrestlers_path(school, season_id: @season.id), notice: "Choose a file to import!"
      end
    end

    def new
     @school = School.find(params[:school_id])
     @league = League.find(@school.league_id)
      @wrestler = @school.wrestlers.new
      @tournaments = Tournament.order('name ASC')
    end



    def create
      @wrestler = Wrestler.new(wrestler_params)
       @wrestler.league = @league.name
      @tournaments = Tournament.order('name ASC')
      @wrestler.league = @league.name
      # @wrestler.season_id = Season.last.id
      user = current_user
      wrestler = @wrestler
      wrestler_array = [user, wrestler]
      respond_to do |format|
        if @wrestler.save
         UserMailer.wrestler_added(wrestler_array).deliver
          format.html { redirect_to league_path(@league), notice: 'wrestler was successfully created.' }
           format.json { render json: @wrestler.errors, status: :unprocessable_entity }
          # added:
          format.js   { render json: @wrestler.errors, status: :unprocessable_entity }
        else

          format.html { render action: 'new' }
          format.json { render json: @wrestler.errors, status: :unprocessable_entity }
          # added:
          format.js   { render json: @wrestler.errors, status: :unprocessable_entity }
        end
      end

    end


    def edit
      @wrestler = Wrestler.find(params[:id])

      uid = @wrestler.school_id
      @school = School.find(@wrestler.school_id)
       @league = League.find_by_id(params[:league_id])

    end

   

    def weight_106
      select_wrestlers(106)
    end

    def weight_113
      select_wrestlers(113)
    end

    def weight_120
      select_wrestlers(120)
    end

    def weight_126
      select_wrestlers(126)
    end

    def weight_132
      select_wrestlers(132)
    end

    def weight_138
      select_wrestlers(138)
    end

    def weight_145
      select_wrestlers(145)
    end

    def weight_152
      select_wrestlers(152)
    end

    def weight_160
      select_wrestlers(160)
    end

    def weight_170
      select_wrestlers(170)
    end

    def weight_182
      select_wrestlers(182)
    end

    def weight_195
      select_wrestlers(195)
    end

    def weight_220
      select_wrestlers(220)
    end

    def weight_285
      select_wrestlers(285)
    end

    def show
      @wrestler = Wrestler.find(params[:id])
    end

    def update

      @wrestler = Wrestler.find(params[:id])
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
          redirect_to league_path(@league)
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
      UserMailer.wrestler_deleted(wrestler_array).deliver
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
        @season = Season.last
        @wrestlers = @season.wrestlers.where(weight: wt).order('weight ASC, wins DESC')
        wrestlers = @season.wrestlers.where(weight: wt).order('seed ASC, wins DESC')  # for csv format

        @count2 = @wrestlers.count

      respond_to do |format|
        format.html
        format.csv { send_data wrestlers.to_csv2({}, teams, wrestlers) }

      end
    end

    def wrestler_params
      params.require(:wrestler).permit(:first_name, :abbreviation, :school, :league_id, :league, :last_name, :weight, :grade, :wins, :losses, :tourney_wins, :league_place, :section_place, :state_place, :seed, :comments, :school_id, :t1_name, :t1_place, :t2_name, :t2_place, :t3_name, :t3_place, :t4_name, :t4_place, :t5_name, :t5_place, :t6_name, :t6_place, :h2h_1, :h2h_r1, :h2h_2, :h2h_r2, :h2h_3, :h2h_r3, :h2h_4, :h2h_r4, :h2h_5, :h2h_r5, :alternate, :fullname, :scratch, :tourney_team, :league_1ya, :losses_ncs, :gender, :season_id)
    end

  end
end