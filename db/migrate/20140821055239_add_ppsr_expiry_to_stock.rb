class AddPpsrExpiryToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :ppsr_expiry, :date
  end
end
