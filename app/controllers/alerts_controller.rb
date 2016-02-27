class AlertsController < ApplicationController



  def index
  end

  def new
    @alert = Alert.new
  end

  def destroy
  end

  def update
  end

  def create
    @alert = Alert.new(alert_params)

    respond_to do |format|

      if @alert.save
        format.html { redirect_to cellnumbers_path, notice: "Your alert was successfully added" }
      else
        format.html { render action: 'new' }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

  end



  private

  def alert_params
    params.require(:alert).permit(:message)
  end

end