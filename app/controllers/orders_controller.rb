class OrdersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    set_order
    @stocks = @order.stock
    @items = @order.item
  end

  # GET /orders/filter/Ordered
  def status_filter
    @order_status = params[:order_status]
    @orders = Order.select { |order| order.order_status == @order_status }
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new
    @order.order_number = order_params[:order_number]
    @order.shipping_date = order_params[:shipping_date]
    @order.order_status = order_params[:order_status]
    @stock_to_generate = order_params[:stock_to_generate].to_i
    @items_to_generate = order_params[:items_to_generate].to_i
    respond_to do |format|
      if @order.save
        StockAudit.create(user_id: current_user.id, comment: "created order #{@order.order_number}", audit_params: "#{order_params}")
        @order.generate_stock(@stock_to_generate, @order, current_user)
        @order.generate_items(@items_to_generate, @order, current_user)
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        StockAudit.create(user_id: current_user.id, comment: "updated status of order #{@order.order_number}", audit_params: "#{order_params}")
        @order.update_stock(@order, current_user)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_number, :shipping_date, :order_status, :stock_to_generate, :items_to_generate)
    end
end
