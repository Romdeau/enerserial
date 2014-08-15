# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  job_number  :string(255)
#  customer_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
