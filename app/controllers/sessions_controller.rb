class SessionsController < ApplicationController

  def new
  end

  def create
    incoming_provider = request.env['omniauth.auth']['provider']
    incoming_uid = request.env['omniauth.auth']['uid']
    incoming_info = request.env['omniauth.auth']['info']
    user = User.find_by(provider: incoming_provider, uid: incoming_uid)
    if user
      # User found
      # sign them in
    else
      # User not found
      # sign them up
      token = SecureRandom.hex(7)
      user = User.create provider: incoming_provider, uid: incoming_uid, nickname: incoming_info['nickname'], token: token
      # register key at service side
      RestClient.post "http://localhost:4000/register.json", :client_user_id => user.id, :token => user.token
    end

    session[:user_id] = user.id
    redirect_to root_url, notice: "Hello!#{user.nickname}"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out"
  end

end