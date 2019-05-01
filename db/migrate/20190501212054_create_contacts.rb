class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :address 
    end
  end
end
