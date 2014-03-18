class Stock < ActiveRecord::Base
  belongs_to :job
  has_one :engine
  has_one :alternator
end
