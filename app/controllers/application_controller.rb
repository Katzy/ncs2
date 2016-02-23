class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  before_filter :initialize_users_for_header

  def configure_devise_permitted_parameters
    registration_params = [:email, :name, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end

  def initialize_users_for_header
    # @users = User.order('school ASC')
    @leagues = League.all
    @leagues1 = @leagues[0..5]
    @leagues2 = @leagues[6..11]
    # @users = User.where.not(league: nil)
    @user = current_user
    @schools = School.order('abbreviation ASC')
    count = @schools.count
    half = count / 2

    @schools1 = @schools[0..half]
    @schools2 = @schools[(half+1)..@schools.count]

    if @user != nil && @user.league_rep == true
      id = @user.league_id
        @league = League.find(@user.league_id)
    end
    # @user_name = current_user.name
    # @user_name = @user_name.split(" ").first
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def authorize_admin
    redirect_to root_path, alert: 'Access Denied' unless (user_signed_in? && current_user.admin?)
  end

  def authorize_user

    redirect_to root_path, alert: 'Access Denied' unless (user_signed_in? && (current_user.admin? || (current_user.league_id == @league.id) || (current_user.school_id == params[:school_id])))
  end

  def require_admin!
    unless user_signed_in? && current_user.admin?
      redirect_to root_url, alert: "You do not have permission!"
    end
  end
end
