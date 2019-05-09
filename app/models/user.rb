class User < ActiveRecord::Base
  has_many :emails
  has_many :contacts, through: :emails
  has_secure_password
  validates :email_address, uniqueness: true
end
