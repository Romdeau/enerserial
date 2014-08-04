class AddItemsToStockAudits < ActiveRecord::Migration
  def change
    add_reference :stock_audits, :item, index: true
  end
end
