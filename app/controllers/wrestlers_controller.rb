class WrestlersController < ApplicationController
  # before_action :load_league, only: [:new, :create]
  # before_filter :authorize_user, :only => [:new, :create]
  def index

    @wrestlers = Wrestler.order('weight ASC, seed ASC, wins DESC')
    wrestlers = Wrestler.order('weight ASC, seed ASC, wins DESC')  # for csv format

    @user = current_user
    @count = @wrestlers.count


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
    @league = League.find(@wrestler.school.league_id)
    @wrestler.league_id = @league.id
    @tournaments = Tournament.order('name ASC')
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
        load_league
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
    @league = League.find(@school.league_id)
    @tournaments = Tournament.all
    p @league.name

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
    @bouts = @wrestler.bouts.all
    @match_number = 1
    @full_name = @wrestler.first_name + ' ' + @wrestler.last_name
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
      @wrestlers = Wrestler.where("weight = #{wt}").order('weight ASC, seed ASC, wins DESC')
      wrestlers = Wrestler.where("weight = #{wt}").order('weight ASC, seed ASC, wins DESC')  # for csv format

      @count2 = @wrestlers.count
      @wins = []
      @losses = []
    respond_to do |format|
      format.html
      format.csv { send_data wrestlers.to_csv2 }
      format.xls { send_data wrestlers.to_csv2({col_sep: "\t"})}

    end
  end

  def wrestler_params
    params.require(:wrestler).permit(:first_name, :abbreviation, :school, :league_id, :league, :last_name, :weight, :grade, :wins, :losses, :tourney_wins, :league_place, :section_place, :state_place, :seed, :comments, :school_id, :t1_name, :t1_place, :t2_name, :t2_place, :t3_name, :t3_place, :t4_name, :t4_place, :t5_name, :t5_place, :h2h_1, :h2h_r1, :h2h_2, :h2h_r2, :h2h_3, :h2h_r3, :h2h_4, :h2h_r4, :h2h_5, :h2h_r5, :alternate)
  end

end