class Stock < ActiveRecord::Base
  belongs_to :job
  has_one :engine
  has_one :alternator

  STATUS_TYPES = %w[New\ Stock Job\ Allocated Manufacturing Ready\ to\ Ship On\ the\ Water]

  validate :serial_number, presence: true
end
