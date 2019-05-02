class EmailsController < ApplicationController

  get '/inbox' do
    if !logged_in?
      redirect to '/login'
    else
      @emails = Email.find_by(user_id: session[:user_id])
      erb :'emails/inbox'
    end
  end

  get '/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'emails/new'
    end
  end

  post '/new' do
    binding.pry
    user = user.find(session[:user)id])
    email = Email.create(content: params[:email][:content])
    contact = Contact.create(address: params[:contact][:address])
    user.emails << email


  end


end
