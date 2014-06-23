class AddShippingDateToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :shipping_date, :date
  end
end
