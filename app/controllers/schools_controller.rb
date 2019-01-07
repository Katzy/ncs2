class SchoolsController < ApplicationController

  def index
    @schools = School.all
  end

  def new

    @school = School.new
  end

  def show
    @school = School.find(params[:id])
    @seasons = Season.all.order('id DESC')
    @season = Season.last
    if SeasonWrestler.where(season_id: @season.id, wrestler_school_id: @school.id).count > 0 
      @wrestlers = @season.wrestlers.where(school_id: @school.id).order('tourney_team ASC, weight ASC')
    else
      @wrestlers = []
    end
    @tourney_results = []
    # @wrestlers.each do |wrestler|
    #   wrestler.bouts.each do |bout|
    #     if bout.tourney_place
    #       @tourney_results.push([bout.tourney_name, bout.tourney_place])
    #     end
    #   end
    # end
  end

  def create
    @user = current_user
    @school = School.new(school_params)
    league = League.find(@school.league_id)
    respond_to do |format|
      if @school.save
        format.html { redirect_to league_path(league), notice: 'school was successfully created.' }
        format.json { render action: 'index', status: :created, location: @school }
        # added:
        format.js   { render action: 'index', status: :created, location: @school }
      else
        format.html { render 'leagues/schools/new' }
        format.json { render json: @school.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @school = School.find(params[:id])

  end

  def update
    league = League.find(School.find(params[:id]).league_id)
    @school = league.schools.find(params[:id])
    
     if @school.update(school_params)
        redirect_to league_path(league)
     else
      render :edit
    end
  end



  def autocomplete 
    query = params[:query].downcase
    @schools = School.where("lower(name) LIKE ?", "%#{query}%")
    render json: { schools: @schools.present_all }
  end

  def destroy
    @user = current_user
    @school = School.find(params[:id])
    @league = @school.league_id
    @school.destroy
    redirect_to league_path(@league)
  end

  private

  def school_params
    params.require(:school).permit(:name, :auth_users, :abbreviation, :head_coach, :address, :league_id)
  end
end