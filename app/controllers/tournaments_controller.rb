
  class TournamentsController < ApplicationController

      def index

      end

      def new

        @tournament = Tournament.new
      end

      def create
        @user = current_user
        @tournament = Tournament.new(tournament_params)

        respond_to do |format|
          if @tournament.save
            format.html { redirect_to tournaments_path, notice: 'tournament was successfully created.' }
            format.json { render action: 'index', status: :created, location: @tournament }
            # added:
            format.js   { render action: 'index', status: :created, location: @tournament }
          else
            format.html { render action: 'new' }
            format.json { render json: @tournament.errors, status: :unprocessable_entity }
            # added:
            format.js   { render json: @tournament.errors, status: :unprocessable_entity }
          end
        end
      end

      def edit
        @tournament = Tournament.find(params[:id])
      end

      def update

       @tournament = Tournament.find(params[:id])
  #      @tournament = team.tournaments.find(params[:id])
        if @tournament.update(tournament_params)
          redirect_to user_wrestlers_path(@user)
        else
          render :edit
        end
      end

      def autocomplete 

        query = params[:query].downcase
        @tournaments = Tournament.where("lower(name) LIKE ?", "%#{query}%")
        
      
        render json: { tournaments: @tournaments.present_all }
      end

      def destroy

        @tournament = Tournament.find(params[:id])
        @tournament.destroy
        redirect_to tournaments_path
      end

      private

      def tournament_params
        params.require(:tournament).permit(:name, :query)
      end
    end