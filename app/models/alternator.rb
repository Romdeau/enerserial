class Alternator < ActiveRecord::Base
  belongs_to :stock

  validate :serial, :alternator, presence: true
end
