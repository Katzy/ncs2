class LeaguesController < ApplicationController

      def index
        @leagues = League.all
      end

      def new

        @league = League.new
      end

      def create
        @user = current_user
        @league = League.new(league_params)

        respond_to do |format|
          if @league.save
            format.html { redirect_to user_leagues_path(@user), notice: 'league was successfully created.' }
            format.json { render action: 'index', status: :created, location: @league }
            # added:
            format.js   { render action: 'index', status: :created, location: @league }
          else
            format.html { render action: 'new' }
            format.json { render json: @league.errors, status: :unprocessable_entity }
            # added:
            format.js   { render json: @league.errors, status: :unprocessable_entity }
          end
        end
      end

      def edit

      end

      def update

      end

      def destroy
        @user = current_user
        @league = League.find(params[:id])
        @league.destroy
        redirect_to leagues_path
      end

      private

      def league_params
        params.require(:league).permit(:name)
      end
    end