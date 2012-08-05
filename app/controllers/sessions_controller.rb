class SessionsController < ApplicationController
  def new
    session[:user_id] = nil
  end

  def create
    puts params
    @user = User.authenticate(params[:login], params[:password])
    puts @user
    
    if @user
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Inicio de sesion"
    else
      flash.now.alert = "Usuario invalido o password incorrecto"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Sali&oacute;"
  end
end
