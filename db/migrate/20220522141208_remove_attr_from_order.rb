class RemoveAttrFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :width, :integer
    remove_column :orders, :depth, :integer
    remove_column :orders, :weight, :integer
    remove_column :orders, :height, :integer
    remove_column :orders, :product_address, :string
    remove_column :orders, :sku, :string
  end
end
