class InformationController < ApplicationController
  def about

  end

  def seeds
    @wrestlers = Wrestler.where("seed >0 AND seed<9")
    wrestlers = Wrestler.where("seed >0 AND seed<9")
    @wrestlers = @wrestlers.order('weight ASC, seed ASC')
    if @wrestlers.count > 0
      @weight = @wrestlers.first.weight
    end

  end

  def alerts
  end

  def schedule
  end



  def send_sms_106

    numbers_to_sms = Cellnumber.where("_106 == true")
    easy = SMSEasy::Client.new
    numbers_to_sms.each do |number|
      easy.deliver(number.cell, number.carrier, "106lb wrestlers have been called to the staging area.  They will be wrestling soon" )
    end

  end

   end