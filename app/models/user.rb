class User < ActiveRecord::Base
  has_many :emails
  has_secure_password
end
