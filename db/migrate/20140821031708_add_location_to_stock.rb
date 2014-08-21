class AddLocationToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :location, :string
  end
end
