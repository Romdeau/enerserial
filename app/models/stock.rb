class Stock < ActiveRecord::Base
  belongs_to :job
  has_one :engine
  has_one :alternator

  validate :serial_number, presence: true
end
