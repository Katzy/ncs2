class WelcomeController < ApplicationController

  def index
    @user = current_user
    @alert = Alert.find(1)
    @alert2 = Alert.find(2)
    @alert3 = Alert.find(3)
  end

end