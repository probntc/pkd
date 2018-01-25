class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user, only: %i(edit show update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.activated.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t "controller.users.check_mail"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    return if @user
    redirect_to root_path && return unless user.activated?
    flash[:danger] = t "controller.users.danger"
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controller.users.update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controller.users.destroy"
      redirect_to @user
    else
      flash[:danger] = t "controller.user.destroy_error"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit User::LIST_PERMIT_USER
  end

  def correct_user
    redirect_to root_path unless @user.current_user? current_user
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "controller.users.pls"
    redirect_to login_path
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "controller.users.must_login"
    redirect_to login_path
  end
end
