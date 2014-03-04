class ChangePriceColumnType < ActiveRecord::Migration
  def change
  rename_column :products, :price, :price_integer
  add_column :products, :price, :decimal, precision: 8, scale: 2

  Product.reset_column_information
  Product.find_each { |e| e.update_attribute(:price, e.price_integer) }
  remove_column :products, :price_integer
  end
end
