class AddColumnsAddressCountryWebsiteToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :address, :text
    add_column :businesses, :country, :text
    add_column :businesses, :website, :text
  end
end
