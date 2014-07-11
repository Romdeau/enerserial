class AddOrderIdToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :order_id, :integer
  end
end
