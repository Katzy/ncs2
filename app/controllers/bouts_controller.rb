class BoutsController < ApplicationController

    def index
      @bouts = Bout.all
    end

    def new
      @wrestler = Wrestler.find(params[:wrestler_id])
      @bout = @wrestler.bouts.new
      @bouts = @wrestler.bouts.all
    end

    def create
      @wrestler = Wrestler.find(bout_params[:wrestler_id])
      @bout = @wrestler.bouts.new(bout_params)

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
      @bout = Bout.find(params[:id])
      @wrestler = Wrestler.find(@bout.wrestler_id)
      @bouts = @wrestler.bouts.order("date ASC")
      @match_number = 1 
    end

    def update
      @bout = Bout.find(params[:id])
      @wrestler = Wrestler.find(@bout.wrestler_id)
      @bouts = @wrestler.bouts.order("date ASC")
      @match_number = 1 
      if @bout.update(bout_params)
      #   if current_user.admin?
      #     redirect_to league_path(@league)
      #   else
          redirect_to wrestler_path(@wrestler)
      #   end
      else
        render :edit
      end
    end



    def destroy
      @bout = Bout.find(params[:id])
      @wrestler = Wrestler.find(@bout.wrestler_id)
      @bout.destroy
      redirect_to wrestler_path(@wrestler)
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