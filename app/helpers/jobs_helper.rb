module JobsHelper
  def format_job(jobid)
    if jobid = ''
      "pending"
    else
      jobid
    end
  end
end
