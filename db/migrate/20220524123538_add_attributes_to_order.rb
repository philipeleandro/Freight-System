# Add position, date and time columns

class AddAttributesToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :position, :string
    add_column :orders, :date, :date
    add_column :orders, :time, :time
  end
end
