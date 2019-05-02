class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/inbox'
    end
  end

  post '/signup' do
    if params.any? {|k, v| v.empty?}
      redirect to '/failure'
    else
      @user = User.create(username: params[:username], email_address: params[:email_address], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/inbox'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      erb :'emails/inbox'
    end
  end

  post '/login' do
    user = User.find_by(email_address: params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      erb :'emails/inbox'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
