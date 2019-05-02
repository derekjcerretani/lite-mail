class Email < ActiveRecord::Base
  belongs_to :user
  has_many :contacts
end
