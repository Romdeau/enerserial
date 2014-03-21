class Stock < ActiveRecord::Base
  belongs_to :job
  has_one :engine
  has_one :alternator

  STATUS_TYPES = %w[preproduction building testing ready\ to\ ship shipping delivered]

  validate :serial_number, presence: true
end
