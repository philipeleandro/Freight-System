class AddAttrToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :width, :integer
    add_column :orders, :depth, :integer
    add_column :orders, :weight, :integer
    add_column :orders, :height, :integer
    add_column :orders, :product_address, :string
    add_column :orders, :sku, :string
  end
end
