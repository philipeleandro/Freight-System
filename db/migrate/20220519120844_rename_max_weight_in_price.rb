# Rename column in prices
 
class RenameMaxWeightInPrice < ActiveRecord::Migration[7.0]
  def change
    rename_column :prices, :max_weigth, :max_weight
  end
end
