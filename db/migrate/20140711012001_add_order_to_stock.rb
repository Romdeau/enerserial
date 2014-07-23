class AddOrderToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :order, :belongs_to
  end
end
