json.array!(@orders) do |order|
  json.extract! order, :id, :order_number, :shipping_date
  json.url order_url(order, format: :json)
end
