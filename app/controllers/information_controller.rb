class InformationController < ApplicationController
  def about

  end

  def send_sms_106

    numbers_to_sms = Cellnumber.where("_106 == true")
    easy = SMSEasy::Client.new
    numbers_to_sms.each do |number|
      easy.deliver(number.cell, number.carrier, "106lb wrestlers have been called to the staging area.  They will be wrestling soon" )
    end

  end

  def results_1993
  end

  def results_1994
  end

  def results_1995
  end

  def results_1996
  end

  def results_1997
  end

  def results_1998
  end

  def results_1999
  end

  def results_2000
  end

  def results_2001
  end

  def results_2002
  end

  def results_2003
  end

  def results_2004
  end

  def results_2005
  end

  def results_2006
  end

  def results_2007
  end

  def results_2008
  end

  def results_2009
  end

  def results_2010
  end

  def results_2011
  end

  def results_2012
  end

  def results_2013
  end

  def results_2014
  end

  def results_2015
  end

  def admin_settings
  end

  def help
  end

  def entry_information
  end

  def schedule
  end

  def map_to_msj
  end

  def place_winners_2014
  end

  def hotels
  end

  def results_prior_years
  end

  def champions_1990_to_2013
  end

  def brackets
  end

  def team_scores
  end

  end
