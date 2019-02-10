class InformationController < ApplicationController
  def about

  end

  def seeds
    @wrestlers = Season.last.wrestlers.where("seed >0 AND seed<12")
    wrestlers = Season.last.wrestlers.where("seed >0 AND seed<912")
    @count = @wrestlers.count
    @wrestlers = @wrestlers.order('weight ASC, seed ASC')
    if @wrestlers.count > 0
      @weight = @wrestlers.first.weight
    end
     respond_to do |format|
      format.html
      format.csv { send_data wrestlers.to_csv2 }
    end
  end

  def alerts
    @alert = Alert.find(1)
    @alert2 = Alert.find(2)
    @alert3 = Alert.find(3)
  end

  def schedule
  end

  def help

  end


  def send_sms_106

    numbers_to_sms = Cellnumber.where("_106 == true")
    easy = SMSEasy::Client.new
    numbers_to_sms.each do |number|
      easy.deliver(number.cell, number.carrier, "106lb wrestlers have been called to the staging area.  They will be wrestling soon" )
    end

  end

   end
