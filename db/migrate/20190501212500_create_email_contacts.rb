class CreateEmailContacts < ActiveRecord::Migration
  def change
    create_table :email_contacts do |t|
      t.integer :user_id
      t.integer :contact_id
    end
  end
end
