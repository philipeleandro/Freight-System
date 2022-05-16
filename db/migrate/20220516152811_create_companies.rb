class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :domain
      t.string :cnpj
      t.string :address
      t.integer :freight
      t.integer :threshold
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
