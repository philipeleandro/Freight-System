# Permit nil in column

class ChangeCarIdFromOrder < ActiveRecord::Migration[7.0]
  def change
    change_column_null :orders, :car_id, true
  end
end
