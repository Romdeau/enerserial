# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  item_name    :string(255)
#  item_model   :string(255)
#  item_serial  :string(255)
#  stock_type   :string(255)
#  order_id     :integer
#  distributor  :string(255)
#  manufacturer :string(255)
#  stock_id     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Item < ActiveRecord::Base
  belongs_to :order
  belongs_to :stock

  has_many :stock_audit

  STOCK_TYPES = %w[Engine Alternator Pump Flare Other]

  validates :item_serial, presence: true, uniqueness: true,
    unless: :blank_serial?

  scope :floor_stock, -> { where stock_id: nil }
  scope :assigned_stock, -> { where stock_id: !nil}

  def blank_serial?
    if item_serial == nil or item_serial == ''
      true
    else
      false
    end
  end
end
