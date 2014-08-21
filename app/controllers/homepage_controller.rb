class HomepageController < ApplicationController
  def index
    @orders = Order.all.reorder("shipping_date DESC").select { |order| order.active_order? }
    @stock = Stock.all.reorder("shipping_date DESC").select { |stock| stock.active_stock? }
  end

  def stylesheet

  end
end
