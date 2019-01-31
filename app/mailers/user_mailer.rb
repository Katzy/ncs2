class UserMailer < ActionMailer::Base
  default from: "ncs-noreply@ncswrestling.com"



  def new_user(user)
    @user = user
    mail(to: @user.email, subject: "NCS WRESTLING CHAMPIONSHIP 2017 / LOGIN DETAILS")
  end

  def generic_message(user)
    @user = user
    mail(to: @user.email, subject: "IMPORTANT NCS WEBSITE INFORMATION")
  end

  def new_user_added(user)
    @user = user
    mail(to: ["scottalankatz@gmail.com", "lhkatz@pacbell.net"], subject: "New User Created")
  end

  def team_updated(user)
    @user = user
    mail(to: "scottalankatz@gmail.com", subject: "Team Info Updated")
  end

  def edit_all(user, wrestlers)
    @user = user
    @wrestlers = wrestlers
    mail(to: "scottalankatz@gmail.com", subject: "Team Edited All")
  end

  def bout_entered(user,wrestler, bout)
    @user = user
    @wrestler = wrestler
    @bout = bout
    mail(to: "scottalankatz@gmail.com", subject: "Bout entered")
  end

  def bout_edited(user,wrestler, bout)
    @user = user
    @wrestler = wrestler
    @bout = bout
    mail(to: "scottalankatz@gmail.com", subject: "Bout edited")
  end

  def bout_deleted(user,wrestler,bout)
    @user = user
    @wrestler = wrestler
    @bout = bout
    mail(to: "scottalankatz@gmail.com", subject: "Bout deleted")
  end    

  def msg_to_coaches(msg_arr)
    @user = msg_arr[0]
    @subject = msg_arr[1]
    @message = msg_arr[2]
  mail(to: @user.email, subject: @subject)
  end
  # def msg_to_coaches([user, subject, message])

  #   @user = user
  #   @message = message
  #   mail(to: @user.email, subject: subject)
  # end

  def team_upload(wrestler_array)
    @user = wrestler_array[0]
    @wrestlers = wrestler_array[1]
    mail(to: ["scottalankatz@gmail.com", "lhkatz@pacbell.net"], subject: "#{@wrestlers[0].school.name} Imported Roster")
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
