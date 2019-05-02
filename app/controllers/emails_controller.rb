class EmailsController < ApplicationController

  get '/inbox' do
    if !logged_in?
      redirect to '/login'
    else
      @emails = Email.all
      erb :'emails/inbox'
    end
  end


end
