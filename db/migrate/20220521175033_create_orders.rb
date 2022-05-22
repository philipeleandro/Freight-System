class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :status
      t.string :code
      t.string :receiver_name
      t.string :delivery_address
      t.references :product, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end
end
