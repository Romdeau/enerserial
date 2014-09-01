class AuditEventToText < ActiveRecord::Migration
  def up
    change_column :stock_audits, :audit_params, :text
end
def down
    # This will cause trouble if you have audit events, as the params will will regularly be over 255 characters.
    change_column :stock_audits, :audit_params, :string
end
end
