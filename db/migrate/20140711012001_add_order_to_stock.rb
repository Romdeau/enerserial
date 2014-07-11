class AddOrderToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :order, :reference
  end
end
