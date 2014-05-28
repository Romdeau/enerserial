class AlternatorsController < ApplicationController
  before_action :set_alternator, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /alternators
  # GET /alternators.json
  def index
    @alternators = Alternator.all
  end

  def floor_stock
    @alternators = Alternator.floor_stock
  end

  # GET /alternators/1
  # GET /alternators/1.json
  def show
    @stock_audits = @alternator.stock_audit
  end

  # GET /alternators/new
  def new
    @alternator = Alternator.new
    @stock = Stock.find(params[:stock_id])
  end

  # GET /alternators/1/edit
  def edit
    @alternator = Alternator.find(params[:id])
  end

  # POST /alternators
  # POST /alternators.json
  def create
    @alternator = Alternator.new(alternator_params)
    @alternator.stock_id = params[:stock_id]
    @stock_audit = StockAudit.new
    @stock_audit.alternator = @alternator
    @stock_audit.user = current_user
    @stock_audit.audit_params = "#{alternator_params}"
    @stock_audit.comment = "created a new engine"
    respond_to do |format|
      if @alternator.save
        @stock_audit.save
        format.html { redirect_to @alternator, notice: 'Alternator was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alternator }
      else
        format.html { render action: 'new' }
        format.json { render json: @alternator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alternators/1
  # PATCH/PUT /alternators/1.json
  def update
    respond_to do |format|
      if @alternator.update(alternator_params)
        @stock_audit = StockAudit.new
        @stock_audit.alternator = @alternator
        @stock_audit.user = current_user
        @stock_audit.audit_params = "#{alternator_params}"
        @stock_audit.comment = "updated alternator"
        @stock_audit.save
        format.html { redirect_to @alternator, notice: 'Alternator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alternator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alternators/1
  # DELETE /alternators/1.json
  def destroy
    @stock_audit = StockAudit.new
    @stock_audit.user = current_user
    @stock_audit.alternator = @alternator
    @stock_audit.comment = "destroyed alternator with an ID of #{@alternator.id}"
    @stock_audit.save
    @alternator.destroy
    respond_to do |format|
      format.html { redirect_to alternators_url }
      format.json { head :no_content }
    end
  end

  def new_floor_alternator
    @alternator = Alternator.new
  end

  def create_floor_alternator
    @alternator = Alternator.new(alternator_params)
    @stock_audit = StockAudit.new
    @stock_audit.alternator = @alternator
    @stock_audit.user = current_user
    @stock_audit.audit_params = "#{alternator_params}"
    @stock_audit.comment = "created a new alternator"
    respond_to do |format|
      if @alternator.save
        @stock_audit.save
        format.html { redirect_to alternators_path, notice: 'Alternator was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alternator }
      else
        format.html { render action: 'new' }
        format.json { render json: @alternator.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_alternator
    @alternator = Alternator.find(params[:id])
  end

  def unassign_alternator
    @stock = Stock.find(params[:id])
    @alternator = @stock.alternator
    @alternator.stock_id = nil
    @stock_audit = StockAudit.new
    @stock_audit.alternator = @alternator
    @stock_audit.user = current_user
    @stock_audit.comment = "alternator assigned to floor stock from stock item #{@stock.id}"
    @stock_audit1 = StockAudit.new
    @stock_audit1.stock = @alternator.stock
    @stock_audit1.user = current_user
    @stock_audit1.comment = "alternator #{@alternator.id} assigned to floor stock"
    if @alternator.save
      @stock_audit.save
      @stock_audit1.save
      redirect_to @alternator, notice: "Alternator #{@alternator.id} was assigned to floor stock"
    else
      redirect_to @alternator, alert: "Something went wrong."
    end
  end

  def process_alternator
    @alternator = Alternator.find(params[:id])
    @stock = Stock.find_by serial_number: alternator_params[:stock_id]
    @alternator.stock_id = @stock.id
    @stock_audit = StockAudit.new
    @stock_audit.alternator = @alternator
    @stock_audit.user = current_user
    @stock_audit.comment = "floor stock alternator assigned to #{@alternator.stock.id}"
    @stock_audit1 = StockAudit.new
    @stock_audit1.stock = @alternator.stock
    @stock_audit1.user = current_user
    @stock_audit1.comment = "floor stock alternator #{@alternator.id} assigned"
    if @alternator.save
      @stock_audit.save
      @stock_audit1.save
      redirect_to @alternator, notice: "Alternator #{@alternator.id} was assigned to #{@stock.id}"
    else
      redirect_to @alternator, alert: "Something went wrong."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alternator
      @alternator = Alternator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alternator_params
      params.require(:alternator).permit(:alternator, :alternator_type, :serial, :stock_id)
    end
end
