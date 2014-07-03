# == Schema Information
#
# Table name: alternators
#
#  id              :integer          not null, primary key
#  stock_id        :integer
#  alternator      :string(255)
#  alternator_type :string(255)
#  serial          :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Alternator < ActiveRecord::Base
  belongs_to :stock
  has_many :stock_audit

  validates :serial, :alternator, presence: true, uniqueness: true

  scope :floor_stock, -> { where stock_id: nil }
	scope :assigned_stock, -> { where stock_id: !nil}
end
