# == Schema Information
#
# Table name: stocks
#
#  id               :integer          not null, primary key
#  serial_number    :integer
#  job_id           :integer
#  detail           :string(255)
#  status           :string(255)
#  status_detail    :string(255)
#  gesan_number     :string(255)
#  ppsr             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  needs_ppsr       :boolean          default(TRUE)
#  supplier_name    :string(255)
#  vin              :string(255)
#  shipping_date    :date
#  order_id         :integer
#  accounts_signoff :integer
#  projects_signoff :integer
#

class Stock < ActiveRecord::Base
  belongs_to :job
  belongs_to :order
  has_one :engine
  has_one :alternator
  has_one :costing
  has_many :item
  has_many :stock_audit

  STATUS_TYPES = %w[Ordered Acknowledged Goods\ Loaded On\ The\ Water Arrived Floor\ Stock New\ Stock In\ Production Production\ Complete Ready\ to\ Dispatch Dispatched]

  validates :serial_number, uniqueness: true,
    unless: :blank_serial?

  validate :stock_valid?

  def valid_job?
    if Job.find_by job_number: job_id != nil
      true
    else
      errors.add(:job_id, "#{job_id} is not a valid job number.")
    end
  end

  def accounts_signoff?
    if status == "Production Complete" and needs_ppsr == true and (ppsr == nil or ppsr == '')
      false
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

  def blank_serial?
    if serial_number == nil or serial_number == ''
      true
    else
      false
    end
  end

  def valid_dispatched?
    if status == "Dispatched" and ( shipping_date == "" or shipping_date == nil)
      errors.add(:status, "Job Cannot be dispatched without a shipping date")
    else
      true
    end
  end

  def stock_valid?
    case status
    when "Floor Stock"
    when "New Stock"
      if job_id == "" or job_id == nil
        errors.add(:status, "Job Cannot be set as New Stock without an allocated job")
      else
        true
      end
    when "In Production"
      if job_id == "" or job_id == nil
        errors.add(:status, "Job Cannot be set as In Production without an allocated job")
      else
        true
      end
    when "Production Complete"
      #check for valid job
      if job_id == "" or job_id == nil
        errors.add(:status, "Job Cannot be set as Production Complete without an allocated job")
      else
        true
      end
    when "Ready to Dispatch"
      #check for sign off
      if accounts_signoff == 1 and projects_signoff == 1
        true
      else
        errors.add(:status, "Job cannot be set as Ready to Dispatch without accounts & projects singoff.")
      end
      #check for valid ppsr
      if needs_ppsr == true and (ppsr == nil or ppsr == '')
        errors.add(:ppsr, "Job cannot be Ready to Dispatch without a PPSR number.")
      else
        true
      end
      #check for valid job
      if job_id == "" or job_id == nil
        errors.add(:status, "Job Cannot be set as Ready to Dispatch without an allocated job")
      else
        true
      end
    when "Dispatched"
      #check for sign off
      if accounts_signoff == 1 and projects_signoff == 1
        true
      else
        errors.add(:status, "Job cannot be set to Dispatched without accounts & projects singoff.")
      end
      #check for valid ppsr
      if needs_ppsr == true and (ppsr == nil or ppsr == '')
        errors.add(:job_id, "#{ppsr} job cannot be set as Dispatched without a PPSR number.")
      else
        true
      end
      #check for valid job
      if job_id == "" or job_id == nil
        errors.add(:status, "Job Cannot be set as Dispatched without an allocated job")
      else
        true
      end
      #check for valid shipping date
      if shipping_date == "" or shipping_date == nil
        errors.add(:status, "Job Cannot be set as Dispatched without a shipping date")
      else
        true
      end
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
        @engine = Item.create(stock_type: "Engine", stock_id: @stock.id, item_name: @stockhash["engine"], item_model: @stockhash["engine_type"], item_serial: @stockhash["engine_serial"])
      end
      #if the alternator exists create it associated with the stock item
      if @stockhash["alternator"] != nil
        @alternator = Item.create(stock_type: "Alternator", stock_id: @stock.id, item_name: @stockhash["alternator"], item_model: @stockhash["alternator_type"], item_serial: @stockhash["alternator_serial"])
      end
    end
  end
end
