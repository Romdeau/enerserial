class Alternator < ActiveRecord::Base
  has_one :stock

  validate :serial, :alternator, presence: true
end
