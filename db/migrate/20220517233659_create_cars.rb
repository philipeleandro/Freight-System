# Create car model

class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :plate
      t.string :model
      t.string :brand
      t.integer :max_load
      t.integer :year
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
