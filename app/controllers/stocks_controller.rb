class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @stock = Stock.find(params[:id])
    @items = @stock.item
    @stock_audits = @stock.stock_audit
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # GET /stocks/import
  def import
  end

  # POST /items/import
  def import_file
    begin
      Stock.import(params[:file])
      redirect_to root_url, notice: "Stock imported. Duplicates are Ignored."
    rescue
      redirect_to root_url, notice: "Invalid CSV file format."
    end
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @job = Job.find_by job_number: stock_params[:job_number]
    params[:stock].delete :job_number
    @stock = Stock.new(stock_params)
    if @job != nil
      @stock.job_id = @job.id
    end
    @stock_audit = StockAudit.new
    @stock_audit.stock = @stock
    @stock_audit.user = current_user
    @stock_audit.audit_params = "#{stock_params}"
    respond_to do |format|
      if @stock.save
        @stock_audit.comment = "has created the new stock item #{@stock.id}"
        @stock_audit.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stock }
      else
        format.html { render action: 'new' }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    @job = Job.find_by job_number: stock_params[:job_number]
    params[:stock].delete :job_number
    if @job.user != nil
      if @stock.status == stock_params[:status]
        @status_updated = false
      else
        @project_manager = User.find(@job.user)
        @status_updated = true
      end
    end
    @stock.update(stock_params)
    if @job != nil
      @stock.job_id = @job.id
    else
      @stock.job_id = nil
    end
    @stock_audit = StockAudit.new
    @stock_audit.user = current_user
    @stock_audit.stock = @stock
    @stock_audit.audit_params = "#{stock_params}"
    @stock_audit.comment = "updated stock"
    respond_to do |format|
      if @stock.save
        @stock_audit.save
        if @status_updated
          if @project_manager != nil
            UserMailer.status_update(@project_manager, @stock, current_user).deliver
          else
            UserMailer.jim_status_update(@stock, current_user).deliver
          end
        end
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock_audit = StockAudit.new
    @stock_audit.user = current_user
    @stock_audit.stock = @stock
    @stock_audit.comment = "destroyed stock unit with an ID of #{@stock.id}"
    @stock_audit.save
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end

  def bulk_edit_stock
    @order = Order.find(params[:id])
    @stock = @order.stock
  end

  def bulk_process_stock
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:serial_number, :job_number, :engine_id, :alternator_id, :detail, :status, :status_detail, :gesan_number, :ppsr, :needs_ppsr, :supplier_name, :vin, :shipping_date, :pm_email)
    end
end
