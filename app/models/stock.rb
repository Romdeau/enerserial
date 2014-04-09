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

  STATUS_TYPES = %w[New\ Stock Job\ Allocated Manufacturing Ready\ to\ Ship On\ the\ Water]

  validate :serial_number, presence: true
  validate :valid_ppsr?

  def valid_job?
    if Job.find_by job_number: job_id != nil
      true
    else
      errors.add(:job_id, "#{job_id} is not a valid job number")
    end
  end

  def valid_ppsr?
    if status == "Ready to Ship" and needs_ppsr == true and ppsr == nil
      errors.add(:job_id, "#{ppsr} job cannot be ready to ship without a PPSR number")
    else
      true
    end
  end
end
