class AddSupplierNameToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :supplier_name, :string
  end
end
