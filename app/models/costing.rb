# == Schema Information
#
# Table name: costings
#
#  id            :integer          not null, primary key
#  foreign_cost  :string(255)
#  exchange_rate :string(255)
#  markup        :string(255)
#  landed_cost   :string(255)
#  stock_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Costing < ActiveRecord::Base
  belongs_to :stock
end
