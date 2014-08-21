class RemoveAlternatorEngineFromStockAudit < ActiveRecord::Migration
  def change
    remove_column :stock_audits, :engine_id
    remove_column :stock_audits, :alternator_id
  end
end
