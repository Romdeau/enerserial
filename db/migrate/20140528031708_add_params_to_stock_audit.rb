class AddParamsToStockAudit < ActiveRecord::Migration
  def change
    add_column :stock_audits, :audit_params, :string
  end
end
