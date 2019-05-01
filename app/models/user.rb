class User < ActiveRecord::Base
  has_many :emails
  has_many :email_contacts
  has_many :contacts, through: :email_contacts
  has_secure_password
end
