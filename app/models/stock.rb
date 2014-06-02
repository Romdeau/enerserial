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
  has_one :engine
  has_one :alternator
  has_many :stock_audit

  STATUS_TYPES = %w[New\ Stock Job\ Allocated Manufacturing Ready\ to\ Ship On\ the\ Water Dispatched]

  validate :serial_number, presence: true
  validate :valid_ppsr?
  validate :valid_serial?

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
end
