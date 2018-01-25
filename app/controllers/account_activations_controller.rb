class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by mail: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      success user
    else
      unsuccess
    end
  end

  private

  def success user
    user.activate
    log_in user
    flash[:success] = t "controller.users.activated"
    redirect_to user
  end

  def unsuccess
    flash[:danger] = t "controller.users.invalid_activate"
    redirect_to root_url
  end
end
