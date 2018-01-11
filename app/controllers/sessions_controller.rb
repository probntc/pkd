class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params_sessions(:email)

    if user && user.authenticate(params_sessions :password)
      success user
    else
      unsuccess
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def success user
    log_in user
    params_sessions(:remember_me) == "1" ? remember(user) : forget(user)
    redirect_to user
  end

  def unsuccess
    flash[:danger] = t "controller.users.invalid"
    render :new
  end
end
