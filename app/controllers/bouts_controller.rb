class BoutsController < ApplicationController

    def index
      @bouts = Bout.all
    end

    def new
      @tourney_results = []
      @wrestler = Wrestler.find(params[:wrestler_id])
      @bout = @wrestler.bouts.new
      @bouts = @wrestler.bouts.all
    end

  

    def create
      @wrestler = Wrestler.find(bout_params[:wrestler_id])
      @bout = @wrestler.bouts.new(bout_params)
      @season = Season.last
      create_tourney
      # @season = Season.find(SeasonWrestler.where(wrestler_id: @wrestler.id)[0].season_id)
      # @bouts = @wrestler.bouts
      # @match_number = 1
      @bout.tourney_name = params[:tourney_name]
      @bout.opponent_name = params[:opponent_name]
      # @bout.opponent_team = params[:opponent_team]
      respond_to do |format|
        if @bout.save
          if !Tournament.exists?(name: @bout.tourney_name)
            Tournament.create(name: @bout.tourney_nam)
          end
          increment_wrestler_record(@bout, @wrestler)
          UserMailer.bout_entered(current_user, @wrestler, @bout).deliver
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


     def download
      wrestler = Wrestler.find(params[:wrestler_id])
      respond_to do |format|
       
        format.csv { send_data bout.download(wrestler), filename: wrestler.last_name + '_results_import_file' + '.csv' }
      end
    end

    def show
    end

    def help
      @wrestler = Wrestler.find(params[:wrestler_id])
    end

    def edit
      @tourney_results = []
      @bout = Bout.find(params[:id])
      @wrestler = Wrestler.find(@bout.wrestler_id)
      @season = Season.find(SeasonWrestler.where(wrestler_id: @wrestler.id)[0].season_id)
      @bouts = @wrestler.bouts.order("date ASC")
      @match_number = 1 
    end

    def update
      @bout = Bout.find(params[:id])
      @wrestler = Wrestler.find(@bout.wrestler_id)
      @bouts = @wrestler.bouts.order("date ASC")
      @tourney_results = []
      @match_number = 1 
      @bout.tourney_name = params[:tourney_name]
      @bout.opponent_name = params[:opponent_name]
      @bout.opponent_team = params[:opponent_team]      
     
      if @bout.update(bout_params)
        UserMailer.bout_edited(current_user, @wrestler, @bout).deliver
        
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
      UserMailer.bout_deleted(current_user, @wrestler, @bout).delier
      update_wrestler_record(@bout, @wrestler)
      redirect_to wrestler_path(@wrestler)
      # @user = current_user
      # @school = School.find(params[:id])
      # @school.destroy
      # redirect_to schools_path
    end

    private

    def change_wrestler_record(bout, w)
      if bout.win_loss == "W"
        w.wins += 1
        w.losses -= 1
      else
        w.wins -= 1
        w.losses += 1
      end
      w.save
    end

    def increment_wrestler_record(bout, wrestler)
      @w = wrestler
      if bout.win_loss == "W"
          @w.wins += 1
      else
          @w.losses += 1
      end
      @w.save
    end

    def update_wrestler_record(bout, w)
      if bout.win_loss == "W"
        w.wins -= 1
      else
        w.losses -= 1
      end
      w.save
    end



    def create_tourney
      if params[:dual_or_tourney] == "Tournament"
      if Tournament.exists?(:name => params[:tourney_name]) == false
        Tournament.create!({ :name => params[:tourney_name] })
      end
    end
    end

    def bout_params
      params.require(:bout).permit(:date, :weight, :dual_or_tourney, :tourney_name, :tourney_seed, :opponent_name, :opponent_team, :win_loss, :result_type, :score_time, :tourney_place, :wrestler_id)
    end
  end