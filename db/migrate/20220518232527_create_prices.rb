class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.integer :min_volume
      t.integer :max_volume
      t.integer :min_weight
      t.integer :max_weigth
      t.integer :value
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
