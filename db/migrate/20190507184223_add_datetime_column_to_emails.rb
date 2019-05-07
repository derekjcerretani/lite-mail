class AddDatetimeColumnToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :created_at, :datetime
  end
end
