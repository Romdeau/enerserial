# == Schema Information
#
# Table name: stock_audits
#
#  id           :integer          not null, primary key
#  stock_id     :integer
#  user_id      :integer
#  comment      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  audit_params :string(255)
#  item_id      :integer
#

require 'test_helper'

class StockAuditTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
