class AlternatorsController < ApplicationController
  before_action :set_alternator, only: [:show, :edit, :update, :destroy]

  # GET /alternators
  # GET /alternators.json
  def index
    @alternators = Alternator.all
  end

  # GET /alternators/1
  # GET /alternators/1.json
  def show
  end

  # GET /alternators/new
  def new
    @alternator = Alternator.new
  end

  # GET /alternators/1/edit
  def edit
  end

  # POST /alternators
  # POST /alternators.json
  def create
    @alternator = Alternator.new(alternator_params)

    respond_to do |format|
      if @alternator.save
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
    @alternator.destroy
    respond_to do |format|
      format.html { redirect_to alternators_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alternator
      @alternator = Alternator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alternator_params
      params.require(:alternator).permit(:alternator, :alternator_type, :serial)
    end
end
