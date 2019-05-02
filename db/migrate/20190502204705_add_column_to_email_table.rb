class AddColumnToEmailTable < ActiveRecord::Migration
  def change
    add_column :emails, :contact_id, :integer
  end
end
