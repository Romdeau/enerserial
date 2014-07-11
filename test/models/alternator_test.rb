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

require 'test_helper'

class AlternatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
