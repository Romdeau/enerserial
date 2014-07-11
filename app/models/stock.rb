# == Schema Information
#
# Table name: stocks
#
#  id            :integer          not null, primary key
#  serial_number :integer
#  job_id        :integer
#  detail        :string(255)
#  status        :string(255)
#  status_detail :string(255)
#  gesan_number  :string(255)
#  ppsr          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  needs_ppsr    :boolean          default(TRUE)
#

class Stock < ActiveRecord::Base
  belongs_to :job
  belongs_to :order
  has_one :engine
  has_one :alternator
  has_many :stock_audit

  STATUS_TYPES = %w[New\ Stock Job\ Allocated Manufacturing Ready\ to\ Ship On\ the\ Water Dispatched]

  validates :serial_number, presence: true, uniqueness: true
  validate :valid_ppsr?
  #validate :valid_serial?
  validate :valid_dispatched?

  def valid_job?
    if Job.find_by job_number: job_id != nil
      true
    else
      errors.add(:job_id, "#{job_id} is not a valid job number.")
    end
  end

  def valid_ppsr?
    if status == "Ready to Ship" and needs_ppsr == true and (ppsr == nil or ppsr == '')
      errors.add(:job_id, "#{ppsr} job cannot be ready to ship without a PPSR number.")
    else
      true
    end
  end

  def valid_serial?
    if needs_ppsr == true and (ppsr == nil or ppsr == '') and (serial_number != nil and serial_number != '')
      errors.add(:serial_number, "Cannot make Serial Number #{serial_number}. Job cannot be assigned a serial number without a valid PPSR.")
    else
      true
    end
  end

  def valid_dispatched?
    if status == "Dispatched" and ( shipping_date == "" or shipping_date == nil)
      errors.add(:status, "Job Cannot be dispatched without a shipping date")
    else
      true
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      @stockhash = row.to_hash

      #If the customer field isnt nil try to match to existing customer. If customer doest exist create.
      if @stockhash["customer"] != nil
        @customer = Customer.find_by name: @stockhash["customer"]
        if @customer == nil
          @customer = Customer.create(name: @stockhash["customer"])
        end
      end

      #if the job isnt nil and the customer isnt nil try to match the existing job. If the job doesnt exist create it.
      if @stockhash["job_id"] != nil and @customer != nil
        @job = Job.find_by job_number: @stockhash["job_id"]
        if @job == nil
          @job = Job.create(job_number: @stockhash["job_id"], customer_id: @customer.id)
        end
      end

      #If job or customer are nil create without job and customer
      #No need to account for individual cases, as customers are only linked through jobs and a job must have a customer.
      if @job == nil or @customer == nil
        @stock = Stock.create(serial_number: @stockhash["serial_number"], detail: @stockhash["detail"], status_detail: @stockhash["status_detail"], gesan_number: @stockhash["gesan_number"], ppsr: @stockhash["ppsr"])
      #else create with full job and customer details
      else
        @stock = Stock.create(serial_number: @stockhash["serial_number"], job_id: @job.id, detail: @stockhash["detail"], status_detail: @stockhash["status_detail"], gesan_number: @stockhash["gesan_number"], ppsr: @stockhash["ppsr"])
      end
      #if the engine exists creat it associated with the stock item
      if @stockhash["engine"] != nil
        @engine = Engine.create(stock_id: @stock.id, engine: @stockhash["engine"], engine_type: @stockhash["engine_type"], serial: @stockhash["engine_serial"])
      end
      #if the alternator exists create it associated with the stock item
      if @stockhash["alternator"] != nil
        @alternator = Alternator.create(stock_id: @stock.id, alternator: @stockhash["alternator"], alternator_type: @stockhash["alternator_type"], serial: @stockhash["alternator_serial"])
      end
    end
  end
end
