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

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
