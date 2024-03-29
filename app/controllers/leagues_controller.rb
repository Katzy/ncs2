class LeaguesController < ApplicationController
  
      def index
        @leagues = League.all.order('name ASC')
        @u_hash = {}
        
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
        @season_id = Season.last.id
        @count = 0
        @lg = League.find(params[:id])
        @schools = School.where("league_id = #{params[:id]}").order('name ASC')
        @school_ids = @schools.map { |school| school.id }
        # @wrestlers = Wrestler.where("league = '#{@lg.name}' OR league_id = '#{@lg.id}'").order('weight ASC, state_place DESC, section_place DESC, seed ASC, wins DESC')
        @wrestlers = Season.last.wrestlers(league_id: params[:id], tourney_team: true)
      end

      def create
        @user = current_user
        @league = League.new(league_params)

        respond_to do |format|
          if @league.save
            format.html { redirect_to leagues_path(@user), notice: 'league was successfully created.' }
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
        @league = League.find(params[:id])
      end

      def update
        @user = current_user
        @league = League.find(params[:id])
        respond_to do |format|
          if @league.update(league_params)
            format.html { redirect_to leagues_path(@user), notice: 'league was successfully updated.' }
            format.json { render json: @league.errors, status: :unprocessable_entity }
            format.js   { render json: @league.errors, status: :unprocessable_entity }
          else
            format.html { render action: 'edit' }
          end
        end
      end

      def destroy
        @user = current_user
        @league = League.find(params[:id])
        @league.destroy
        redirect_to leagues_path
      end

      def detach
        @league = League.find(params[:id])
        @school = School.find(params[:school_id])
        @wrestlers = @school.wrestlers
        @league.schools.delete(@school)
        @wrestlers.each do |wr|
          @league.wrestlers.delete(wr)
        end
        redirect_to league_path(@league)
      end

      def add_school
        @league = League.find(params[:id])
        @school = School.new
      end

      def add_school_create
        @league = League.find(params[:school][:league_id])
        @school = School.where(name: params[:name])[0]
        @wrestlers = @school.wrestlers
        @school.league_id = @league.id
        @wrestlers.each do |wr|
          wr.league_id = @league.id
          wr.save
        end
        respond_to do |format|
          if @school.save
            format.html { redirect_to leagues_path(@league), notice: 'league was successfully created.' }
            format.json { render action: 'index', status: :created, location: @league }
            # added:
            format.js   { render action: 'index', status: :created, location: @league }
          else
            format.html { render action: 'add_school' }
            format.json { render json: @league.errors, status: :unprocessable_entity }
            # added:
            format.js   { render json: @league.errors, status: :unprocessable_entity }
          end
        end
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
        params.require(:league).permit(:name, :league_rep, :cell, :email)
      end
    end