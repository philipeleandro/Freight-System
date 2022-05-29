# Create product model
 
class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :width
      t.integer :depth
      t.integer :weight
      t.integer :height
      t.string :address
      t.string :sku

      t.timestamps
    end
  end
end
