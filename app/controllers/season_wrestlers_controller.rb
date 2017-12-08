class SeasonWrestlersController < ApplicationController

  def new
    @season_wrestler = SeasonWrestler.new
  end

  def create
     @season_wrestler = SeasonWrestler.new(season_wrestler_params)
    respond_to do |format|
      if @season_wrestler.save
        format.html { redirect_to welcome_path, notice: 'season wrestler was successfully created.' }
         format.json { render json: @season_wrestler.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @season_wrestler.errors, status: :unprocessable_entity }
      else
        format.html { render action: 'new' }
        format.json { render json: @season_wrestler.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @season_wrestler.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    
  end

  def show
  end

  private 

  def season_wrestler_params
    params.require(:season_wrestler).permit(:school_id, :season_id, :wrestler_id)
  end
end


# class SeasonsController < ApplicationController

#   def new
#     @season = Season.new
#   end

#   def create
#     @season = Season.new(season_params)
#     respond_to do |format|
#       if @season.save
#         format.html { redirect_to welcome_path, notice: 'season was successfully created.' }
#          format.json { render json: @season.errors, status: :unprocessable_entity }
#         # added:
#         format.js   { render json: @season.errors, status: :unprocessable_entity }
#       else
#         format.html { render action: 'new' }
#         format.json { render json: @season.errors, status: :unprocessable_entity }
#         # added:
#         format.js   { render json: @season.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   def season_params
#     params.require(:season).permit(:name, :start_date, :end_date)
#   end  
# end