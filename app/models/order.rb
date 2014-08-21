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
  has_many :item

  validates :order_number, presence: :true, uniqueness: :true

  attr_accessor :stock_to_generate
  attr_accessor :items_to_generate

  STATUS_TYPES = %w[Ordered Acknowledged Goods\ Loaded On\ The\ Water Arrived]

  def generate_stock(number_to_generate, order_object, current_user)
    while number_to_generate > 0
        @stock = Stock.create(status: "Ordered", detail: "Generated for order #{order_object.order_number}", order_id: order_object.id)
        StockAudit.create(user_id: current_user.id, stock_id: @stock.id, comment: "created stock #{@stock.id} for #{order_object.order_number}")
      number_to_generate -= 1
    end
  end

  def generate_items(number_to_generate, order_object, current_user)
    while number_to_generate > 0
        @item = Item.create(item_model: "Generated for order #{order_object.order_number}", order_id: order_object.id)
        StockAudit.create(user_id: current_user.id, item_id: @item.id, comment: "created item #{@item.id} for #{order_object.order_number}")
      number_to_generate -= 1
    end
  end

  def update_stock(updated_order, current_user)
    @stocks = updated_order.stock
    @stocks.each do |stock_item|
      if updated_order.order_status == "Arrived"
        if stock_item.job != nil
          stock_item.update(status: "New Stock")
          if stock_item.job.user != nil
            UserMailer.status_update(stock_item.job.user, stock_item, current_user).deliver
          else
            UserMailer.jim_status_update(stock_item, current_user).deliver
          end
        else
          stock_item.update(status: "Floor Stock")
          UserMailer.jim_status_update(stock_item, current_user).deliver
        end
      elsif stock_item.update(status: updated_order.order_status) and stock_item.job != nil
        if stock_item.job.user_id != nil
          UserMailer.status_update(stock_item.job.user, stock_item, current_user).deliver
        else
          UserMailer.jim_status_update(stock_item, current_user).deliver
        end
      else
        UserMailer.jim_status_update(stock_item, current_user).deliver
      end
    end
  end

  def active_order?
    if order_status != "Arrived"
      if shipping_date != nil
        true
      else
        false
      end
    else
      false
    end
  end

end
