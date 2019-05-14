require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect to '/inbox'
    end
  end

  post '/signup' do
    if params.any? {|k, v| v.empty?}
      flash[:message] = "Please fill out all forms."
      erb :'users/failure'
    else
      user = User.create(username: params[:username], email_address: params[:email_address], password: params[:password])
      contact = Contact.find_or_create_by(address: params[:email_address])
      session[:user_id] = user.id
      contact.user_id = session[:user_id]
      contact.save
      user.save
      binding.pry
      if user.id == nil
        flash[:message] = "That email address is already registered."
        redirect to '/login'
      end
      redirect to '/login'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to :'/inbox'
    end
  end

  post '/login' do
    user = User.find_by(email_address: params[:email_address])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to :'/inbox'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "Successfully logged out."
      redirect to '/'
    end
  end

end
