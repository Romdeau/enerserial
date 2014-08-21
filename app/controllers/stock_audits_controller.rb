class StockAuditsController < ApplicationController
  before_action :set_stock_audit, only: [:show, :edit, :update, :destroy]

  # GET /stock_audits
  # GET /stock_audits.json
  def index
    @stock_audits = StockAudit.all
  end

  # GET /stock_audits/1
  # GET /stock_audits/1.json
  def show
  end

  # GET /stock_audits/new
  def new
    @stock_audit = StockAudit.new
  end

  # GET /stock_audits/1/edit
  def edit
  end

  # POST /stock_audits
  # POST /stock_audits.json
  def create
    @stock_audit = StockAudit.new(stock_audit_params)

    respond_to do |format|
      if @stock_audit.save
        format.html { redirect_to @stock_audit, notice: 'Stock audit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stock_audit }
      else
        format.html { render action: 'new' }
        format.json { render json: @stock_audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_audits/1
  # PATCH/PUT /stock_audits/1.json
  def update
    respond_to do |format|
      if @stock_audit.update(stock_audit_params)
        format.html { redirect_to @stock_audit, notice: 'Stock audit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stock_audit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_audits/1
  # DELETE /stock_audits/1.json
  def destroy
    @stock_audit.destroy
    respond_to do |format|
      format.html { redirect_to stock_audits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_audit
      @stock_audit = StockAudit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_audit_params
      params.require(:stock_audit).permit(:stock, :user, :comment)
    end
end
