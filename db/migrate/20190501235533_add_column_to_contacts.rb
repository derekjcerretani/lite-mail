class AddColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :email_id, :integer
  end
end
