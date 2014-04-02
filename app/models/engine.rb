class Engine < ActiveRecord::Base
  belongs_to :stock

  validate :serial, :engine, presence: true
end
