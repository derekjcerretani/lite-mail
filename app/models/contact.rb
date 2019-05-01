class Contact < ActiveRecord::Base
  has_many :users through: :emails
end
