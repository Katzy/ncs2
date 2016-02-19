class UsersController < ApplicationController

  # before_filter :authorize_admin, only: :create
  before_filter :authenticate_user!, :only => [:edit, :update]
  #before_filter :skip_password_attribute, only: :update

  def home
    @user = current_user
    # @wrestlers = @user.wrestlers.order('weight ASC')
    # @wrestler = @user.wrestlers.new
    # @tournament = @user.tournaments.new
    # @tournaments = @user.tournaments.order('id ASC')
    # @number = 1
  end

  # def send
  #   @users = User.all
  #   @users.each do |user|
  #     UserMailer.new_user(user).deliver
  #   end
  #     redirect_to root_url
  # end



  def index
    @user = current_user
    @users = User.order('league ASC, school Asc')
    users = User.order('school Asc')
    respond_to do |format|
      format.html
      format.csv { send_data users.to_csv }
      format.xls { send_data users.to_csv(col_sep: "\t")}
    end
  end

  def new
    @user = User.new
    @lgs = []
    @l = League.all
    @l.each do |league|
      @lgs << league.name
    end
    # @teams = Team.all
  end

  def edit

    @user = User.find(params[:id])
  end

  def update
    @users = User.order('name ASC')
    @user = User.find_by_id(params[:id])
    # if params[:tournaments]
    #   params[:tournaments][:id].each do |tournament|
    #     if tournament != ""
    #       @user.usertournaments.build(:tournament_id => tournament)
    #     end
    #   end
    # end
    if @user.update(user_params)
      if current_user.admin?
        redirect_to users_path
      else
        redirect_to user_path(@user)
      end
    else
      render :edit
    end
  end


  def create
     @user = User.create(user_params)
    if @user.persisted?
      # @team = Team.new
      # @team.school = @user.school
      # @team.user_id = @user.id
      # @team = Team.create(team_params)
       UserMailer.new_user(@user).deliver
       UserMailer.new_user_added(@user).deliver
      redirect_to root_url, notice: "User was successfully created"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    # @tournaments = @user.tournaments.order('name ASC')

    # @wrestlers = @user.wrestlers.order('weight ASC')
  end

  def all_teams_no_entry
    @users = User.all
    @users.each do |user|
      if user.school != "" && user.school != nil
        no_entry_fill(user)
      end
    end
    redirect_to users_path
  end

#   def delete_tourney

#     @user = User.find(params[:id])
#     tournament = Tournament.find(params[:format])
#     @user.tournaments.delete tournament

#     redirect_to user_tournaments_path(@user)
#   end

#   def remove_from_team
#     @team = Team.find(params[:team_id]) #can do that in before_filter
#     user = User.find(params[:id])
#     @team.members.delete user
#     redirect_to @team
# end

#   def remove
#   end
#   # def no_entry

#   #   @user = User.find(params[:user_id])
#   #   no_entry_fill(@user)
#   #   redirect_to user_wrestlers_path(@user)

#   # end

#   def destroy
#     @users = User.order('name ASC')
#     @user = User.find_by_id(params[:id])
#     # @tournaments = @user.tournaments.all
#     @wrestlers = @user.wrestlers.all
#     @wrestlers.each do |wrestler|
#       wrestler.destroy
#     end
#     # @tournaments.destroy
#     @user.destroy
#     redirect_to users_path
#   end

  private

  def no_entry_fill(user)
    weights = ['106', '113', '120', '126', '132', '138', '145', '152', '160', '170', '182', '195', '220', '285']
    team_weights = []
    @wrestlers = user.wrestlers.order('weight ASC')
    @wrestlers.each do |wrestler|
      team_weights.push(wrestler.weight.to_s)
    end

    weights = weights - team_weights

    weights.each do |weight|
      @wrestler = user.wrestlers.create([:weight => weight.to_i, :last_name => "NO_ENTRY", :first_name => "NO_ENTRY", :grade => "00", :wins => "00", :losses => "00"])
    end
  end

  def skip_password_attribute
    if params[:password].blank? && params[:password_validation].blank?
      params.except!(:password, :password_validation)
    end
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :abbreviation, :cell, :league_id, :school_id, :admin, :league_rep )
  end


end