# Add column to user
 
class AddKindToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :kind, :string
  end
end
