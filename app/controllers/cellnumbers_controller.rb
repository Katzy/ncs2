class CellnumbersController < ApplicationController
  before_filter :authorize_admin, :only => [:index]
  MESSAGE = "lb CHAMPIONSHIP to the staging area."
  MESSAGE_B = "lb CONSOLATION to the staging area."

  def index
    @numbers = Cellnumber.all
    @alert = Alert.last
    @message = "*** #{MESSAGE}"
    @messageb = "*** #{MESSAGE_B}"
    @numbers106 = Cellnumber.where("alert_106 = true")
    @numbers113 = Cellnumber.where("alert_113 = true")
    @numbers120 = Cellnumber.where("alert_120 = true")
    @numbers126 = Cellnumber.where("alert_126 = true")
    @numbers132 = Cellnumber.where("alert_132 = true")
    @numbers138 = Cellnumber.where("alert_138 = true")
    @numbers145 = Cellnumber.where("alert_145 = true")
    @numbers152 = Cellnumber.where("alert_152 = true")
    @numbers160 = Cellnumber.where("alert_160 = true")
    @numbers170 = Cellnumber.where("alert_170 = true")
    @numbers182 = Cellnumber.where("alert_182 = true")
    @numbers195 = Cellnumber.where("alert_195 = true")
    @numbers220 = Cellnumber.where("alert_220 = true")
    @numbers285 = Cellnumber.where("alert_285 = true")
  end

  def new
    @cellnumber = Cellnumber.new
  end

  def destroy
    @cellnumber = Cellnumber.find(params[:id])
    @cellnumber.destroy
    redirect_to root_url, notice: "Your number was successfuly removed from the alert list!"

  end

  def remove
    @number = Cellnumber.new
  end

  def create
    @cellnumber = Cellnumber.new(cellnumber_params)
    @cellnumber.cell = @cellnumber.cell.gsub(/[^0-9]/i, '')

    respond_to do |format|

      if @cellnumber.save
        easy = SMSEasy::Client.new
        easy.deliver("#{@cellnumber.cell}", "#{@cellnumber.carrier_name}", "You've been added to NCS TOURNEY alerts list!  To remove your number from our Alerts, visit www.ncswrestling.com/cellnumbers/#{@cellnumber.id}")
         # UserMailer.wrestler_added(wrestler_array).deliver
          format.html { redirect_to root_url, notice: "Your number was successfully added to the alert list" }
      else
        format.html { render action: 'new' }
        format.json { render json: @cellnumber.errors, status: :unprocessable_entity }
        # added:
        format.js   { render json: @cellnumber.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    if Cellnumber.find_by_id(params[:id]) == nil
      redirect_to root_url, notice: "Your number is not receiving any alerts.  You probably already removed it.  Good work you.  You have my permission to give yourself a pat on the back for a job well done.  Now go seize the moment and buy a candy."
    else
      @cellnumber = Cellnumber.find(params[:id])
    end
  end

  def send_alert_coaches
  end

  def send_alert_all
    @numbers = Cellnumber.all
    @alert = Alert.last
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "#{@alert.message}")
    end
    redirect_to cellnumbers_path
  end

  def send_alert_106
    @numbers = Cellnumber.where(:alert_106 => true)
    find_alerts
    if @alert1.message != "106 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "106 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "106 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_106_cons
    @numbers = Cellnumber.where(:alert_106 => true)
    find_alerts
    if @alert1.message != "106 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "106 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "106 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_113
    @numbers = Cellnumber.where(:alert_113 => true)
    find_alerts
    if @alert1.message != "113 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "113 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "113 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_113_cons
    @numbers = Cellnumber.where(:alert_113 => true)
    find_alerts
    if @alert1.message != "113 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "113 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "113 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_120
    @numbers = Cellnumber.where(:alert_120 => true)
    find_alerts
    if @alert1.message != "120 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "120 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "120 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_120_cons
    @numbers = Cellnumber.where(:alert_120 => true)
    find_alerts
    if @alert1.message != "120 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "120 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "120 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_126
    @numbers = Cellnumber.where(:alert_126 => true)
    find_alerts
    if @alert1.message != "126 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "126 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "126 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_126_cons
    @numbers = Cellnumber.where(:alert_126 => true)
    find_alerts
    if @alert1.message != "126 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "126 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "126 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end


  def send_alert_132
    @numbers = Cellnumber.where(:alert_132 => true)
    find_alerts
    if @alert1.message != "132 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "132 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "132 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_132_cons
    @numbers = Cellnumber.where(:alert_132 => true)
    find_alerts
    if @alert1.message != "132 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "132 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "132 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_138
    @numbers = Cellnumber.where(:alert_138 => true)
    find_alerts
    if @alert1.message != "138 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "138 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "138 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_138_cons
    @numbers = Cellnumber.where(:alert_138 => true)
    find_alerts
    if @alert1.message != "138 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "138 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "138 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_145
    @numbers = Cellnumber.where(:alert_145 => true)
    find_alerts
    if @alert1.message != "145 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "145 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "145 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_145_cons
    @numbers = Cellnumber.where(:alert_145 => true)
    find_alerts
    if @alert1.message != "145 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "145 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "145 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_152
    @numbers = Cellnumber.where(:alert_152 => true)
    find_alerts
    if @alert1.message != "152 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "152 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "152 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_152_cons
    @numbers = Cellnumber.where(:alert_152 => true)
    find_alerts
    if @alert1.message != "152 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "152 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "152 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_160
    @numbers = Cellnumber.where(:alert_160 => true)
    find_alerts
    if @alert1.message != "160 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "160 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "160 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_160_cons
    @numbers = Cellnumber.where(:alert_160 => true)
    find_alerts
    if @alert1.message != "160 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "160 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "160 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_170
    @numbers = Cellnumber.where(:alert_170 => true)
    find_alerts
    if @alert1.message != "170 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "170 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "170 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_170_cons
    @numbers = Cellnumber.where(:alert_170 => true)
    find_alerts
    if @alert1.message != "170 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "170 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "170 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_182
    @numbers = Cellnumber.where(:alert_182 => true)
    find_alerts
    if @alert1.message != "182 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "182 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "182 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_182_cons
    @numbers = Cellnumber.where(:alert_182 => true)
    find_alerts
    if @alert1.message != "182 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "182 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "182 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_195
    @numbers = Cellnumber.where(:alert_195 => true)
    find_alerts
    if @alert1.message != "195 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "195 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "195 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_195_cons
    @numbers = Cellnumber.where(:alert_195 => true)
    find_alerts
    if @alert1.message != "195 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "195 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "195 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_220
    @numbers = Cellnumber.where(:alert_220 => true)
    find_alerts
    if @alert1.message != "220 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "220 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "220 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_220_cons
    @numbers = Cellnumber.where(:alert_220 => true)
    find_alerts
    if @alert1.message != "220 CONSOLATION"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "220 CONSOLATION"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "220 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_285
    @numbers = Cellnumber.where(:alert_285 => true)
    find_alerts
    if @alert1.message != "285 CHAMPIONSHIP"
    @alert = Alert.find(1)
    shift_recent_alert
    @alert.message = "285 CHAMPIONSHIP"
    @alert.save
    easy = SMSEasy::Client.new
    @numbers.each do |number|
      easy.deliver("#{number.cell}", "#{number.carrier_name}", "285 #{MESSAGE}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
    end
  end
    redirect_to cellnumbers_path
  end

  def send_alert_285_cons
    @numbers = Cellnumber.where(:alert_285 => true)
    find_alerts

    if @alert1.message != "285 CONSOLATION"
      @alert = Alert.find(1)
      shift_recent_alert
      @alert.message = "285 CONSOLATION"
      @alert.save
      easy = SMSEasy::Client.new
      @numbers.each do |number|
        easy.deliver("#{number.cell}", "#{number.carrier_name}", "285 #{MESSAGE_B}  To unsubscribe,visit www.ncswrestling.com/cellnumbers/#{number.id}")
      end
    end
    redirect_to cellnumbers_path
  end

  private

  def find_alerts
    @alert3 = Alert.find(3)
    @alert2 = Alert.find(2)
    @alert1 = Alert.find(1)
  end

  def shift_recent_alert
    @alert3.message = @alert2.message
    @alert3.save
    @alert2.message = @alert.message
    @alert2.save
  end

  def cellnumber_params
    params.require(:cellnumber).permit(:cell, :carrier_name, :alert_106, :alert_113, :alert_120, :alert_126, :alert_132, :alert_138, :alert_145, :alert_152, :alert_160, :alert_170, :alert_182, :alert_195, :alert_220, :alert_285)
  end

end