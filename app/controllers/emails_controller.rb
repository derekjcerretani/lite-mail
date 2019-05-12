class EmailsController < ApplicationController

  get '/inbox' do
    if !logged_in?
      redirect to '/login'
    else
      @sent_emails = @current_user.emails.where(user_id: session[:user_id])

      @received_emails = Email.where(contact_id: Contact.where(user_id: @current_user.id))

      @contacts = @current_user.contacts

      erb :'emails/index' , :layout => :mailbox
    end
  end

  get '/new' do
    if !logged_in?
      redirect to '/login'
    else
      @contacts = @current_user.contacts
      erb :'emails/new' , :layout => :mailbox
    end
  end

  post '/inbox' do
    if !logged_in?
      redirect to '/login'
    else
      if !params[:email][:content].empty? && !params[:contact][:address].empty?
        email = Email.new(content: params[:email][:content])
        contact = Contact.find_or_create_by(address: params[:contact][:address])

        email.user = @current_user
        email.contact = contact
        email.save
        redirect to "/show_outbox/#{contact.address}"
      else
        redirect to '/new'
      end
    end
  end

  get '/show_outbox/:contact' do
    if !logged_in?
      redirect to '/login'
    else
      emails = []
      @contact = Contact.find_by(address: params[:contact])

      emails << @sent_emails = Email.where(contact_id: Contact.where(address: params[:contact]), user_id: @current_user.id)

      emails << @recieved_emails = Email.where(contact_id: @current_user.id, user_id: Contact.where(address: params[:contact]))

      @conversation = emails.flatten.sort_by { |email| email.created_at}

      if !emails.nil?
        erb :'/emails/show_email_outbox' , :layout => :mailbox
      else
        redirect to '/inbox'
      end
    end
  end

  get '/edit/:id' do
    if !logged_in?
      redirect to '/login'
    else
      @email = @current_user.emails.find(params[:id])
      if @email
        erb :'/emails/edit_email' , :layout => :mailbox
      else
        redirect to '/inbox'
      end
    end
  end

  patch '/edit/:id' do
    if !logged_in?
      redirect '/login'
    else
      if !params[:content].empty?
        @email = Email.find(params[:id])
        @email.update(content: params[:content])
        redirect to "/show_outbox/#{@email.contact.address}"
        binding.pry
      else
        redirect to "/edit/#{@email.id}"
      end
    end
  end

  delete '/edit/:id/delete' do
    if !logged_in?
      redirect '/login'
    else
      email = Email.find(params[:id])
      contact = Contact.find(email.contact_id)
      email.delete
      redirect to "/show_outbox/#{contact.address}"
    end
  end


end
