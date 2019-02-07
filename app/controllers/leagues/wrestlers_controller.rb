module Leagues
  class WrestlersController < ApplicationController
    before_action :load_league, only: [:new, :create]
    before_filter :authorize_user, :only => [:new, :create, :edit, :update]
    def index
      @lg = League.find(params[:league_id])
       @schools = School.where("league_id = #{params[:league_id]}")
        @school_ids = @schools.map { |school| school.id }
        # @wrestlers = Season.find(@season.id).wrestlers.where(league_id: @lg.id, tourney_team: true).order('weight ASC, seed ASC, league_place ASC, state_place ASC, section_place ASC, win_tally DESC')
        if params[:season_id]
          @season = Season.find(params[:season_id])
        else
          @season = Season.last
        end
        if @season.id != 1
          @wrestlers = Season.find(@season.id).wrestlers.where(league_id: @lg.id, tourney_team: true).order('weight ASC, seed ASC, league_place ASC, state_place ASC, section_place ASC, win_tally DESC')
        else
          @wrestlers = Season.find(@season.id).wrestlers.where(league_id: @lg.id).order('weight ASC, seed ASC, league_place ASC, state_place ASC, section_place ASC, win_tally DESC')
        end
        @league_placers = Season.last.wrestlers.where(league_id: @lg.id, tourney_team: true).where.not(league_place: nil, league_place: "").order('weight ASC, league_place ASC')
        # @wrestlers = @lg.wrestlers.order('weight ASC, seed ASC, league_place ASC, state_place ASC, section_place ASC, wins DESC')
       # @wrestlers = Wrestler.where("league = '#{@lg.name}'").order('weight ASC, seed ASC, wins DESC')
         wrestlers = @wrestlers

      teams = School.where(league_id: 10).order('name ASC')
      @user = current_user
      @count = @wrestlers.count
      @wins = []
      @losses = []
      @tourneys = []
      @tourney_results = []
      league_wrestlers_file = @lg.name + "_" + "wrestlers.xlsx"
      respond_to do |format|
        format.html
        format.json { render json: @wrestlers }
         if user_signed_in? && @lg.id == 10 && (current_user.id == 265 || current_user.id == 206)
          format.csv { send_data wrestlers.to_csv3({}, teams, wrestlers), filename: @lg.name + 'TWT_wrestlers' + '.csv' }
        else 
          format.csv { send_data wrestlers.to_csv2, filename: @lg.name + '_wrestlers' + '.csv' }
        end
        format.xlsx{
          xlsx_package = Wrestler.to_xlsx
          begin 
            temp = Tempfile.new(league_wrestlers_file) 
            xlsx_package.serialize temp.path
            send_file temp.path, :filename => league_wrestlers_file, :type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
          ensure
            temp.close 
            temp.unlink
          end
        }
        format.pdf do
        render pdf: "#{@lg.name}_wrestler_weight_cards.pdf",
               layout: "wrestler_pdf", 
               template: "leagues/wrestlers/index.pdf.erb",
               locals: { :wrestlers => @league_placers },
               orientation: "Landscape"
        end
      end
    end

    def new
      @league = League.find_by_id(params[:league_id])

      @wrestler = Wrestler.new
      @tournaments = Tournament.order('name ASC')
    end



    def create
      @wrestler = Wrestler.new(wrestler_params)
       @wrestler.league = @league.name
      @tournaments = Tournament.order('name ASC')
      @wrestler.league = @league.name
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

    def edit_all
      @wrestlers = Season.last.wrestlers.where(league_id: params[:league_id], tourney_team: true).order('weight ASC')
      @lg = League.find(params[:league_id])

    end

    def update_all
      @wrestlers = Wrestler.update(params[:wrestlers].keys, params[:wrestlers].values)
      @wrestlers.reject! { |p| p.errors.empty? }
      if @wrestlers.empty?
        # UserMailer.edit_all(current_user, Wrestler.find(params[:wrestlers].keys)).deliver
        redirect_to league_wrestlers_path(League.find(params[:league_id]))
      else
        render "edit_all"
      end
    end

    def show
      p "hiihihihih"
      # @wrestler = Wrestler.find(params[:id])

      @bouts = @wrestler.bouts.all
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
        @wrestlers = Wrestler.where("weight = #{wt}").order('weight ASC, state_place ASC, section_place ASC, wins DESC')
        wrestlers = Wrestler.where("weight = #{wt}").order('seed ASC, wins DESC')  # for csv format

        @count2 = @wrestlers.count

      respond_to do |format|
        format.html
        format.csv { send_data wrestlers.to_csv2({}, teams, wrestlers) }

      end
    end

    def wrestler_params
      params.require(:wrestler).permit(:first_name, :abbreviation, :school, :league_id, :league, :last_name, :weight, :grade, :wins, :losses, :tourney_wins, :league_place, :section_place, :state_place, :seed, :comments, :school_id, :t1_name, :t1_place, :t2_name, :t2_place, :t3_name, :t3_place, :t4_name, :t4_place, :t5_name, :t5_place, :t6_name, :t6_place, :h2h_1, :h2h_r1, :h2h_2, :h2h_r2, :h2h_3, :h2h_r3, :h2h_4, :h2h_r4, :h2h_5, :h2h_r5, :alternate, :fullname, :scratch)
    end

  end
end