json.array!(@stocks) do |stock|
  json.extract! stock, :id, :serial_number, :job_id, :engine_id, :alternator_id, :detail, :status, :status_detail, :gesan_number, :ppsr
  json.url stock_url(stock, format: :json)
end
