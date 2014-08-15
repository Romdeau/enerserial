class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
    @customer = @job.customer
    @stocks = @job.stock
  end

  # GET /jobs/new
  def new
    @job = Job.new
    @customer = Customer.find(params[:customer_id])
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.customer_id = params[:customer_id]
    respond_to do |format|
      if @job.save
        format.html { redirect_to jobs_path, notice: 'Job was successfully created.' }
        format.json { render action: 'show', status: :created, location: @job }
      else
        format.html { render action: 'new' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

  # GET /stocks/1/assign_pm
  def assign_pm
    @job = Job.find(params[:id])
    if @job.user != nil
      @pm = User.find(@job.user)
    end
  end

  # PATCH /stocks/1/assign_pm
  def process_pm
    @project_manager = User.find_by email: job_params[:pm_email]
    @job = Job.find(params[:id])
    if @project_manager != nil
      @job.user_id = @project_manager.id
    end
    respond_to do |format|
      if @job.save && @project_manager != nil
        UserMailer.update_pm(@project_manager, @job, current_user).deliver
        format.html { redirect_to @job, notice: 'PM was assigned.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @job, alert: 'PM assignement failed, invalid Enerserial User.' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:job_number, :customer_id, :user_id, :pm_email)
    end
end
