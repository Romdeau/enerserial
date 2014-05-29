class EnginesController < ApplicationController
  before_action :set_engine, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /engines
  # GET /engines.json
  def index
    @engines = Engine.all
  end

  def floor_stock
    @engines = Engine.floor_stock
  end

  # GET /engines/1
  # GET /engines/1.json
  def show
    @stock_audits = @engine.stock_audit
  end

  # GET /engines/new
  def new
    @engine = Engine.new
    @stock = Stock.find(params[:stock_id])
  end

  # GET /engines/1/edit
  def edit
    @engine = Engine.find(params[:id])
  end

  # POST /engines
  # POST /engines.json
  def create
    stock = Stock.find(params[:stock_id])
    if stock.engine != nil
      redirect_to stock_path(stock), alert: 'This Stock item already has an engine'
    else
      @engine = Engine.new(engine_params)
      @engine.stock_id = params[:stock_id]
      @stock_audit = StockAudit.new
      @stock_audit.engine = @engine
      @stock_audit.user = current_user
      @stock_audit.audit_params = "#{engine_params}"
      @stock_audit.comment = "created a new engine"
      respond_to do |format|
        if @engine.save
          @stock_audit.save
          format.html { redirect_to @engine, notice: 'Engine was successfully created.' }
          format.json { render action: 'show', status: :created, location: @engine }
        else
          format.html { render action: 'new' }
          format.json { render json: @engine.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /engines/1
  # PATCH/PUT /engines/1.json
  def update
    respond_to do |format|
      if @engine.update(engine_params)
        @stock_audit = StockAudit.new
        @stock_audit.engine = @engine
        @stock_audit.user = current_user
        @stock_audit.audit_params = "#{engine_params}"
        @stock_audit.comment = "updated engine"
        @stock_audit.save
        format.html { redirect_to @engine, notice: 'Engine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engines/1
  # DELETE /engines/1.json
  def destroy
    @stock_audit = StockAudit.new
    @stock_audit.user = current_user
    @stock_audit.engine = @engine
    @stock_audit.comment = "destroyed engine with an ID of #{@engine.id}"
    @stock_audit.save
    @engine.destroy
    respond_to do |format|
      format.html { redirect_to engines_url }
      format.json { head :no_content }
    end
  end

  def new_floor_engine
    @engine = Engine.new
  end

  def create_floor_engine
    @engine = Engine.new(engine_params)
    @stock_audit = StockAudit.new
    @stock_audit.engine = @engine
    @stock_audit.user = current_user
    @stock_audit.audit_params = "#{engine_params}"
    @stock_audit.comment = "created a new engine"
    respond_to do |format|
      if @engine.save
        @stock_audit.save
        format.html { redirect_to engines_path, notice: 'Engine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @engine }
      else
        format.html { render action: 'new' }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign_engine
    @engine = Engine.find(params[:id])

  end

  def unassign_engine
    @stock = Stock.find(params[:id])
    @engine = @stock.engine
    @engine.stock_id = nil
    @stock_audit = StockAudit.new
    @stock_audit.engine = @engine
    @stock_audit.user = current_user
    @stock_audit.comment = "engine assigned to floor stock from stock item #{@stock.id}"
    @stock_audit1 = StockAudit.new
    @stock_audit1.stock = @engine.stock
    @stock_audit1.user = current_user
    @stock_audit1.comment = "engine #{@engine.id} assigned to floor stock"
    if @engine.save
      @stock_audit.save
      @stock_audit1.save
      redirect_to @engine, notice: "Engine #{@engine.id} was assigned to floor stock"
    else
      redirect_to @engine, alert: "Something went wrong."
    end
  end

  def process_engine
    @engine = Engine.find(params[:id])
    @stock = Stock.find_by serial_number: engine_params[:stock_id]
    @engine.stock_id = @stock.id
    @stock_audit = StockAudit.new
    @stock_audit.engine = @engine
    @stock_audit.user = current_user
    @stock_audit.comment = "floor stock engine assigned to stock ID #{@engine.stock.id}"
    @stock_audit1 = StockAudit.new
    @stock_audit1.stock = @engine.stock
    @stock_audit1.user = current_user
    @stock_audit1.comment = "floor stock engine #{@engine.id} assigned to Stock Item"
    if @engine.save
      @stock_audit.save
      @stock_audit1.save
      redirect_to @engine, notice: "Engine #{@engine.id} was assigned to #{@stock.id}"
    else
      redirect_to @engine, alert: "Something went wrong."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engine
      @engine = Engine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engine_params
      params.require(:engine).permit(:engine, :engine_type, :serial, :stock_id)
    end
end
