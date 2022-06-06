class SessionsController < ApplicationController
  def new
  end

  def create

    @user = User.find_by({email: params["email"]})

    if @user 
      if BCrypt::Password.new(@user.password) == params["password"]
        session["user_id"] = @user.id 
        flash[:notice] = "Welcome! You are logged in!"
        redirect_to "/places"
      else 
        flash[:notice] = "Password is incorrect. Try Again!"
        redirect_to "/sessions/new"
      end 
    else 
      flash[:notice] = "Username not found!"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash[:notice] = "You are out!"
    redirect_to "/sessions/new"
  end
end
  