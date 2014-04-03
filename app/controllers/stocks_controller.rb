class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)
    @job = Job.find_by job_number: stock_params[:job_id]
    @stock.job_id = @job.id
    respond_to do |format|
      if @stock.save
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
    @stock.update(stock_params)
    if @job != nil
      @stock.job_id = @job.id
      respond_to do |format|
        if @stock.save
          format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @stock.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to edit_stock_path(@stock), alert: "Invalid Job Entry, all other changes were saved."
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:serial_number, :job_number, :engine_id, :alternator_id, :detail, :status, :status_detail, :gesan_number, :ppsr)
    end
end
