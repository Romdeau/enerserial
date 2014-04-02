class Stock < ActiveRecord::Base
  belongs_to :job
  has_one :engine
  has_one :alternator

  STATUS_TYPES = %w[New\ Stock Job\ Allocated Manufacturing Ready\ to\ Ship On\ the\ Water]

  validate :serial_number, presence: true
  #validate :valid_job?

  def valid_job?
    if Job.find_by job_number: job_id != nil
      true
    else
      errors.add(:job_id, "#{job_id} is not a valid job number")
    end
  end
end
