class LeaguesController < ApplicationController

      def index
        @leagues = League.all
        @u_hash = {}
        @wrestler_count_hash = {}

        @users = User.where('league_id IS NOT NULL')
        @users.each do |user|
          @u_hash[user.league_id.to_s] = user.name
        end
        @wrestlers = Wrestler.all
      end

      def new

        @league = League.new
      end

      def show
        @count = 0
        @lg = League.find(params[:id])
        @schools = School.where("league_id = #{params[:id]}")
        @school_ids = @schools.map { |school| school.id }
        @wrestlers = Wrestler.where("league = '#{@lg.name}'").order('weight ASC, seed ASC, wins DESC')

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


      def load_league
    #get product_type from session if it is blank
    params[:id] ||= session[:id]
    #save product_type to session for future requests
    session[:id] = params[:id]
    if params[:id]
      @league = League.find(params[:id])

    end
  end

      def league_params
        params.require(:league).permit(:name)
      end
    end