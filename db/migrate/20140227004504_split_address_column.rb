class SplitAddressColumn < ActiveRecord::Migration
  def change
    add_column :orders, :street_address, :string
    add_column :orders, :city, :string
    add_column :orders, :state,  :string
    add_column :orders, :country, :string
    remove_column :orders, :mailing_address, :string
  end
end
