class CostingsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_action :set_costing, only: [:show, :edit, :update, :destroy]

  # GET /costings
  # GET /costings.json
  def index
    @costings = Costing.all
  end

  # GET /costings/1
  # GET /costings/1.json
  def show
  end

  # GET /costings/new
  def new
    @costing = Costing.new
  end

  # GET /costings/1/edit
  def edit
  end

  # POST /costings
  # POST /costings.json
  def create
    @stock = Stock.find(params[:stock_id])
    @costing = Costing.new(costing_params)
    @costing.landed_cost = @costing.foreign_cost.to_i * ((100 + @costing.markup.to_f ) / 100)
    @costing.stock_id = @stock.id
    respond_to do |format|
      if @costing.save
        format.html { redirect_to @costing, notice: 'Costing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @costing }
      else
        format.html { render action: 'new' }
        format.json { render json: @costing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /costings/1
  # PATCH/PUT /costings/1.json
  def update
    @costing.update(costing_params)
    @costing.landed_cost = @costing.foreign_cost.to_i * ((100 + @costing.markup.to_f ) / 100)
    respond_to do |format|
      if @costing.save
        format.html { redirect_to @costing, notice: 'Costing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @costing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /costings/1
  # DELETE /costings/1.json
  def destroy
    @costing.destroy
    respond_to do |format|
      format.html { redirect_to costings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_costing
      @costing = Costing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def costing_params
      params.require(:costing).permit(:foreign_cost, :markup, :stock_id)
    end
end
