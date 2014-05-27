json.array!(@stock_audits) do |stock_audit|
  json.extract! stock_audit, :id, :stock, :engine, :alternator, :user, :comment
  json.url stock_audit_url(stock_audit, format: :json)
end
