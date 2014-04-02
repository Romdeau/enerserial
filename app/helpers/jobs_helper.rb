module JobsHelper
  def format_job(job)
    if job == nil
      "pending"
    else
      job
    end
  end

  def format_company(job)
    if job.customer == nil
      "Unnamed Company"
    else
      job.customer.name
    end
  end
end
