class Engine < ActiveRecord::Base
  belongs_to :stock

  validate :serial, :engine, presence: true

  scope :floor_stock, -> { where stock_id: nil }
  scope :assigned_stock, -> { where stock_id: !nil}
end
