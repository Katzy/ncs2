module Wrestlers
  class BoutsController < ApplicationController


    def index
      @wrestler = Wrestler.find(params[:wrestler_id])
      @matches = @wrestler.matches.order('date ASC')
    end

    def new
      @wrestler = Wrestler.find(params[:wrestler_id])
      @bout = @wrestler.bouts.new
      @season = Season.last
      @tournaments = []
      @tourney_results = []
      Tournament.all.each{ |t| @tournaments << t.name }
      @tournament = Tournament.new
      @bouts = @wrestler.bouts.order("id ASC")
      @match_number = 1
    end

    def new_tourney
       @season = Season.last
      @tournaments = []
      @tourney_results = []
      Tournament.all.each{ |t| @tournaments << t.name }
      @tournament = Tournament.new
       @match_number = 1
      @wrestler = Wrestler.find(params[:wrestler_id])
      @wr_bouts = []
      @bouts = @wrestler.bouts.order("id ASC")
      8.times do
        @wr_bouts << @wrestler.bouts.new
      end
    end

     def download
      wrestler = Wrestler.find(params[:wrestler_id])
      respond_to do |format|
       
        format.csv { send_data Bout.download(wrestler), filename: wrestler.last_name + '_results_import_file' + '.csv' }
      end
    end

    def show

    end

    def import
      if params[:file] != nil
        CSV.foreach(params[:file].path, headers: true) do |row|
          if Bout.exists?(wrestler_id: row[0], weight: row[2], date: row[1], opponent_name: row[4], opponent_team: row[5])
           row
          else
           Bout.create! row.to_hash
           update_wrestler_record(Bout.last, Wrestler.find(row[0]))
           
         end
        end
       redirect_to wrestler_path(Wrestler.find(params[:wrestler_id])), notice: "Import successful"
      #   Wrestler.find(params[:wrestler_id]).bouts.import(params[:file])
      #   redirect_to wrestler_path(Wrestler.find(params[:wrestler_id])), notice: "Import successful"
      else
        redirect_to wrestler_path(Wrestler.find(params[:wrestler_id])), alert: "Choose file to import"
      end
    end

    def create
      @wrestler = Wrestler.find(params[:wrestler_id])
      @bout = @wrestler.bout.new(bout_params)
      # @season = Season.find(SeasonWrestler.where(wrestler_id: @wrestler.id)[0].season_id)
      @season = Season.last
      respond_to do |format|
        if @bout.save
          update_wrestler_record(@bout, @wrestler)
          format.html { redirect_to wrestler_path(@wrestler, season: @season), notice: 'bout was successfully created.' }
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

    def help
      @wrestler = Wrestler.find(params[:wrestler_id])
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

    def update_wrestler_record(bout, wrestler)
      @w = wrestler
      if bout.win_loss == "W"
          @w.wins += 1
      else
          @w.losses += 1
      end
      @w.save
    end

    def bout_params
      params.require(:bout).permit(:date, :weight, :dual_or_tourney, :tourney_name, :tourney_seed, :opponent_name, :opponent_team, :win_loss, :result_type, :score_time, :tourney_place, :wrestler_id)
    end
  end
end