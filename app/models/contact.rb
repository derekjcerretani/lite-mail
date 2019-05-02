class Contact < ActiveRecord::Base
  belongs_to :email
  has_many :email_contacts
  has_many :users, through: :email_contacts
end
