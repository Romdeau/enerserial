# == Schema Information
#
# Table name: stock_audits
#
#  id            :integer          not null, primary key
#  stock_id      :integer
#  engine_id     :integer
#  alternator_id :integer
#  user_id       :integer
#  comment       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  audit_params  :string(255)
#

class StockAudit < ActiveRecord::Base
  belongs_to :stock
  belongs_to :engine
  belongs_to :alternator
  belongs_to :user
  belongs_to :item
end
