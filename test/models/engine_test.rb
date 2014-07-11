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

require 'test_helper'

class EngineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
