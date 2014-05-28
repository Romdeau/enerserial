# == Schema Information
#
# Table name: engines
#
#  id          :integer          not null, primary key
#  stock_id    :integer
#  engine      :string(255)
#  engine_type :string(255)
#  serial      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Engine < ActiveRecord::Base
  belongs_to :stock
  has_many :stock_audit

  validate :serial, :engine, presence: true

  scope :floor_stock, -> { where stock_id: nil }
  scope :assigned_stock, -> { where stock_id: !nil}
end
