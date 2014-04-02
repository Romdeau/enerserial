class EnginesController < ApplicationController
  before_action :set_engine, only: [:show, :edit, :update, :destroy]

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
      respond_to do |format|
        if @engine.save
          format.html { redirect_to engines_path, notice: 'Engine was successfully created.' }
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
    respond_to do |format|
      if @engine.save
        format.html { redirect_to engines_path, notice: 'Engine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @engine }
      else
        format.html { render action: 'new' }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engine
      @engine = Engine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engine_params
      params.require(:engine).permit(:engine, :engine_type, :serial)
    end
end