class AddVinToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :vin, :string
  end
end
