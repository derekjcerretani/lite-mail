class Contact < ActiveRecord::Base
  has_many :email_contacts
  has_many :users, through: :email_contacts
end
