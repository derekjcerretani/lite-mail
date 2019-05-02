class EmailsController < ApplicationController

  get '/inbox' do
    if !logged_in?
      redirect to '/login'
    else
      @sent_emails = Email.where(user_id: session[:user_id])
      @recieved_emails = Email.where(contact_id: session[:user_id])
      @contacts = @current_user.contacts
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

  post '/inbox' do
    if !logged_in?
      redirect to '/login'
    else
      email = Email.create(content: params[:email][:content])
      contact = Contact.find_or_create_by(address: params[:contact][:address])
      email.user = @current_user
      email.contact = contact
      @current_user.emails << email
      contact.emails << email
      email.save
      binding.pry
      redirect to '/inbox'
    end
  end


end
