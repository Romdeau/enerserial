class HomepageController < ApplicationController
  def index
    @orders = Order.all.reorder("shipping_date DESC").select { |order| order.active_order? }
    @stock = Stock.all.reorder("shipping_date DESC").select { |stock| stock.active_stock? }
    @ppsr = Stock.all.reorder("ppsr_expiry DESC").select { |stock| stock.completed_ppsr? }
  end

  def stylesheet

  end
end
