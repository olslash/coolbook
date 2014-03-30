class SessionsController < ApplicationController
  def new

  end

  def create
    user= User.where(email: params[:email].downcase).first #i guess where is better than find_by_email
    if user && user.authenticate(params[:password])
      flash.now[:success] = "authenticated"
      sign_in user
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end

  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
