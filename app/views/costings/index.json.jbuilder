json.array!(@costings) do |costing|
  json.extract! costing, :id, :foreign_cost, :exchange_rate, :markup, :landed_cost, :stock_id
  json.url costing_url(costing, format: :json)
end
