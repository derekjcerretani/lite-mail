class EmailsController < ApplicationController

  get '/inbox' do
    if !logged_in?
      redirect to '/login'
    else
      @emails = Email.find_by(session[:user_id])
      binding.pry
      erb :'emails/inbox'
    end
  end


end
