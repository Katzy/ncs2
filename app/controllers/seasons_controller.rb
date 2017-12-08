class SeasonsController < ApplicationController

  def new
    @season = Season.new
  end

  def create
    @season = Season.new(season_params)
    respond_to do |format|
      if @season.save
        format.html { redirect_to welcome_path, notice: 'season was successfully created.' }
         format.json { render json: @season.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @season.errors, status: :unprocessable_entity }
      else
        format.html { render action: 'new' }
        format.json { render json: @season.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  def season_params
    params.require(:season).permit(:name, :start_date, :end_date)
  end  
end

 
  # def show
  #   @wrestler = Wrestler.find(params[:id])
  #   wrestler = @wrestler
  #   @bouts = @wrestler.bouts.all
  #   @match_number = 1
  #   @full_name = @wrestler.first_name + ' ' + @wrestler.last_name
  #   respond_to do |format|
  #     format.html { render :show }
  #     format.pdf do
  #       render pdf: "#{@wrestler.first_name}_#{@wrestler.last_name}_#{@wrestler.weight}.pdf",
  #              layout: "wrestler_pdf", 
  #              template: "wrestlers/show.pdf.erb",
  #              locals: { :wrestler => wrestler }
  #     end
  #   end
  # end

  # def update

   
  # end

  # def destroy_all
  #   # Wrestler.delete_all
  #   # respond_to do |format|
  #   #   format.html { redirect_to wrestlers_path }
  #   #   format.json { head :no_content }
  #   # end
  # end


  # def destroy
  #   # user = current_user
  #   # @wrestler = Wrestler.find(params[:id])
  #   # wrestler = @wrestler
  #   # wrestler_array = [user, wrestler]
  #   # @wrestler.destroy
  #   # # UserMailer.wrestler_deleted(wrestler_array).deliver
  #   # redirect_to :back
  # end

  # 