json.array!(@engines) do |engine|
  json.extract! engine, :id, :engine, :type, :serial
  json.url engine_url(engine, format: :json)
end
