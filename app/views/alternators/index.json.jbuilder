json.array!(@alternators) do |alternator|
  json.extract! alternator, :id, :alternator, :type, :serial
  json.url alternator_url(alternator, format: :json)
end
