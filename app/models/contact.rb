class Contact < ActiveRecord::Base
  has_many :emails
  has_many :users, through: :emails
end
