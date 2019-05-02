class Contact < ActiveRecord::Base
  has_many :emails
  has_many :email_contacts
  has_many :users, through: :email_contacts
end
