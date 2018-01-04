class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params_sessions(:email)

    if user && user.authenticate(params_sessions :password)
      log_in user
      redirect_to user
    else
      flash.now[:danger] = t "controller.users.invalid"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
