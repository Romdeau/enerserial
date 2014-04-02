class Engine < ActiveRecord::Base
  has_one :stock

  validate :serial, :engine, presence: true
end
