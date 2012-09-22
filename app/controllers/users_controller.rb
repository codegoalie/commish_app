class UsersController < ApplicationController

  def request_access
    if params[:email].present?
      UserMailer.request_email(params[:email]).deliver

      flash[:success] = 'Thanks for requesting access! Check your email for updates!'
      redirect_to root_path
    else
      flash[:alert] = 'Please enter an email address.'
      redirect_to root_path
    end
  end
end
