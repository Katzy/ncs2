module Wrestlers
  class BoutsController < ApplicationController

    def index
      @wrestler = Wrestler.find(params[:wrestler_id])
      @matches = @wrestler.matches.all
    end

    def new
      @wrestler = Wrestler.find(params[:wrestler_id])
      @bout = @wrestler.bouts.new
      @bouts = @wrestler.bouts.order("date ASC")
      @match_number = 1
    end


    def import
      if params[:file] != nil
        Wrestler.find(params[:wrestler_id]).bouts.import(params[:file])
        redirect_to wrestler_path(Wrestler.find(params[:wrestler_id])), notice: "Import successful"
      else
        redirect_to wrestler_path(Wrestler.find(params[:wrestler_id])), alert: "Choose file to import"
      end
    end

    def create
      @wrestler = Wrestler.find(params[:wrestler_id])
      @bout = @wrestler.bout.new(bout_params)

      respond_to do |format|
        if @bout.save
          format.html { redirect_to wrestler_path(@wrestler), notice: 'bout was successfully created.' }
          format.json { render action: 'wrestlers/show', status: :created, location: @wrestler }
          # added:
          format.js   { render action: 'show', status: :created, location: @wrestler }
        else
          format.html { render action: 'new' }
          format.json { render json: @bout.errors, status: :unprocessable_entity }
          # added:
          format.js   { render json: @bout.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @wrestler = Wrestler.find(params[:id])
      @bouts = @wrestler.bouts.order("date ASC")
    end

    def update
      # @wrestler = Wrestler.find(params[:id])
      # @school = School.find(params[:id])
      # @bout = @wrestler.boutes.find(@school.league_id)
      # if @school.update(school_params)
      #   if current_user.admin?
      #     redirect_to league_path(@league)
      #   else
      #     redirect_to root_path
      #   end
      # else
      #   render :edit
      # end
    end



    def destroy
      # @user = current_user
      # @school = School.find(params[:id])
      # @school.destroy
      # redirect_to schools_path
    end

    private
 
    def bout_params
      params.require(:bout).permit(:date, :weight, :dual_or_tourney, :tourney_name, :tourney_seed, :opponent_name, :win_loss, :result_type, :score_time, :tourney_place, :wrestler_id)
    end
  end
end