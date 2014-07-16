# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  order_number  :string(255)
#  shipping_date :date
#  created_at    :datetime
#  updated_at    :datetime
#  order_status  :string(255)
#

class Order < ActiveRecord::Base
  has_many :stock

  validates :order_number, presence: :true, uniqueness: :true
  
  attr_accessor :stock_to_generate

  STATUS_TYPES = %w[Ordered Acknowledged Goods\ Loaded On\ The\ Water Arrived Floor\ Stock New\ Stock Job\ Allocated In\ Production Ready\ to\ Ship Ready\ to\ Dispatch Dispatched]

  def generate_stock(number_to_generate, order_object)
    while number_to_generate > 0
        Stock.create(status: "Ordered", detail: "Generated for order #{order_object.order_number}", order_id: order_object.id)
      number_to_generate -= 1
    end
  end

end
