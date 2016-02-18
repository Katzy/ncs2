module Leagues
  class SchoolsController < ApplicationController

    def index
      @league = League.find(params[:league_id])
      @schools = @league.schools.all
    end

    def new
      @league = League.find(params[:league_id])
      @school = @league.schools.new
    end

    def create
      @user = current_user
      @school = School.new(school_params)

      respond_to do |format|
        if @school.save
          format.html { redirect_to user_schools_path(@user), notice: 'school was successfully created.' }
          format.json { render action: 'index', status: :created, location: @school }
          # added:
          format.js   { render action: 'index', status: :created, location: @school }
        else
          format.html { render action: 'new' }
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
      @school = School.find(params[:id])
      @league = League.find(@school.league_id)
      if @school.update(school_params)
        if current_user.admin?
          redirect_to league_path(@league)
        else
          redirect_to root_path
        end
      else
        render :edit
      end
    end



    def destroy
      @user = current_user
      @school = School.find(params[:id])
      @school.destroy
      redirect_to schools_path
    end

    private

    def school_params
      params.require(:school).permit(:name, :auth_users, :abbreviation, :head_coach, :address, :league_id)
    end
  end
end