
class SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.find_by(username: params[:session][:username])
    if admin && admin.authenticate(params[:session][:password]) && params[:session][:password] == params[:session][:password_confirmation]
      session[:admin_id] = admin.id
      redirect_to admin_dashboard_path
    else
      flash.now[:error] = 'Invalid username, password, or password confirmation'
      render 'new'
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to root_path
  end
end
