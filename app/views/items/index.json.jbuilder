json.array!(@items) do |item|
  json.extract! item, :id, :item_name, :item_model, :item_serial, :stock_type, :order_id, :distributor, :manufacturer, :stock_id
  json.url item_url(item, format: :json)
end
