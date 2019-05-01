class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.text :content
      t.integer :user_id
    end
  end
end
