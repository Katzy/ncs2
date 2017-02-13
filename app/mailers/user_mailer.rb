class UserMailer < ActionMailer::Base
  default from: "ncs-noreply@ncswrestling.com"



  def new_user(user)
    @user = user
    mail(to: @user.email, subject: "NCS WRESTLING CHAMPIONSHIP 2017 / LOGIN DETAILS")
  end

  def new_user_added(user)
    @user = user
    mail(to: ["scottalankatz@gmail.com", "lhkatz@pacbell.net"], subject: "New User Created")
  end

  def team_updated(user)
    @user = user
    mail(to: "scottalankatz@gmail.com", subject: "Team Info Updated")
  end


  def team_upload(wrestler_array)
    @user = wrestler_array[0]
    @wrestlers = wrestler_array[1]
    mail(to: ["scottalankatz@gmail.com", "lhkatz@pacbell.net"], subject: "#{@user.school.name} Imported Roster")
  end

  def wrestler_updated(wrestler_array)
     @user = wrestler_array[0]
    @wrestler = wrestler_array[1]

    mail(to: ["scottalankatz@gmail.com", "lhkatz@pacbell.net"], subject: "Wrestler Info Updated")
  end

  def wrestler_added(wrestler_array)
    @user = wrestler_array[0]
    @wrestler = wrestler_array[1]

    mail(to: ["scottalankatz@gmail.com", "lhkatz@pacbell.net"], subject: "Wrestler Added")
  end

  def wrestler_deleted(wrestler_array)
     @user = wrestler_array[0]
    @wrestler = wrestler_array[1]

    mail(to: ["scottalankatz@gmail.com", "lhkatz@pacbell.net"], subject: "Wrestler Deleted")
  end
end
