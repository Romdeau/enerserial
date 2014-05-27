class StockAudit < ActiveRecord::Base
  belongs_to :stock
  belongs_to :engine
  belongs_to :alternator
  belongs_to :user
end
