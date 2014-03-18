class Job < ActiveRecord::Base
  belongs_to :customer
  has_many :stock
end
