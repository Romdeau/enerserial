# == Schema Information
#
# Table name: stocks
#
#  id               :integer          not null, primary key
#  serial_number    :integer
#  job_id           :integer
#  detail           :string(255)
#  status           :string(255)
#  status_detail    :string(255)
#  gesan_number     :string(255)
#  ppsr             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  needs_ppsr       :boolean          default(TRUE)
#  supplier_name    :string(255)
#  vin              :string(255)
#  shipping_date    :date
#  order_id         :integer
#  accounts_signoff :integer
#  projects_signoff :integer
#  location         :string(255)
#  ppsr_expiry      :date
#

require 'test_helper'

class StockTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
