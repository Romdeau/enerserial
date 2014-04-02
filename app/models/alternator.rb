class Alternator < ActiveRecord::Base
  belongs_to :stock

  validate :serial, :alternator, presence: true

  scope :floor_stock, -> { where stock_id: nil }
	scope :assigned_stock, -> { where approved: !nil}
end
