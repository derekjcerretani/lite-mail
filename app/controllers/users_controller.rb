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
      contact = Contact.find_by(address: params[:email_address])
      if contact
        user = User.new(username: params[:username], email_address: contact.address, password: params[:password])
        user.save
        session[:user_id] = user.id
        contact.user_id = session[:user_id]
        contact.save
      else
        user = User.create(username: params[:username], email_address: params[:email_address], password: params[:password])
        contact = Contact.create(address: params[:email_address], user_id: user.id)
        session[:user_id] = user.id
      end
      redirect to '/inbox'
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
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
