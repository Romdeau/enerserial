class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  def floor_stock
    @items = Item.floor_stock
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  def new_floor_item
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.stock_id = params[:stock_id]
    @stock_audit = StockAudit.new
    @stock_audit.item = @item
    @stock_audit.user = current_user
    @stock_audit.audit_params = "#{item_params}"
    @stock_audit.comment = "created a new item"
    respond_to do |format|
      if @item.save
        @stock_audit.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_floor_item
    @item = Item.new(item_params)
    @stock_audit = StockAudit.new
    @stock_audit.item = @item
    @stock_audit.user = current_user
    @stock_audit.audit_params = "#{item_params}"
    @stock_audit.comment = "created a new item"
    respond_to do |format|
      if @item.save
        @stock_audit.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_item
    @item = Item.find(params[:id])
    @stocks = Stock.all
  end

  def unassign_item
    @item = Item.find(params[:id])
    @stock = @item.stock
    @item.stock_id = nil
    @stock_audit = StockAudit.new
    @stock_audit.item = @item
    @stock_audit.user = current_user
    @stock_audit.comment = "item #{@item} assigned to floor stock"
    @stock_audit1 = StockAudit.new
    @stock_audit1.stock = @item.stock
    @stock_audit1.user = current_user
    @stock_audit1.comment = "stock item #{@item.id} assigned to floor stock"
    if @item.save
      @stock_audit.save
      @stock_audit1.save
      redirect_to @item, notice: "Item #{@item.id} was assigned to #{@stock.id}"
    else
      redirect_to @item, alert: "Something went wrong."
    end
  end

  def process_item
    @item = Item.find(params[:id])
    @stock = Stock.find_by serial_number: item_params[:stock_id]
    @item.stock_id = @stock.id
    @stock_audit = StockAudit.new
    @stock_audit.item = @item
    @stock_audit.user = current_user
    @stock_audit.comment = "floor stock item assigned to #{@item.stock.id}"
    @stock_audit1 = StockAudit.new
    @stock_audit1.stock = @item.stock
    @stock_audit1.user = current_user
    @stock_audit1.comment = "floor stock item #{@item.id} assigned"
    if @item.save
      @stock_audit.save
      @stock_audit1.save
      redirect_to @item, notice: "Item #{@item.id} was assigned to #{@stock.id}"
    else
      redirect_to @item, alert: "Something went wrong."
    end
  end
  def item_stock
    @stock = Stock.find(params[:stock_id])
    @item = Item.find(params[:id])
  end

  def process_item_stock
    @item = Item.find(params[:id])
    @stock = Stock.find(params[:stock_id])
    @item.stock_id = @stock.id
    @stock_audit = StockAudit.new
    @stock_audit.item = @item
    @stock_audit.user = current_user
    @stock_audit.comment = "floor stock item assigned to #{@item.stock.id}"
    @stock_audit1 = StockAudit.new
    @stock_audit1.stock = @item.stock
    @stock_audit1.user = current_user
    @stock_audit1.comment = "floor stock item #{@item.id} assigned"
    if @item.save
      @stock_audit.save
      @stock_audit1.save
      redirect_to @stock, notice: "Item #{@item.id} was assigned to #{@stock.id}"
    else
      redirect_to @item, alert: "Something went wrong."
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def bulk_edit_items
    @order = Order.find(params[:id])
    @items = @order.item
  end

  def bulk_process_items
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:item_name, :item_model, :item_serial, :stock_type, :order_id, :distributor, :manufacturer, :stock_id)
    end
end
