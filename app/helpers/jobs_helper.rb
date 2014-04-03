module JobsHelper
  def format_job(stock)
    if stock.job == nil
      "pending"
    else
      stock.job.job_number
    end
  end

  def format_company(stock)
    if stock.job.customer == nil
      "Unnamed Company"
    else
      stock.job.customer.name
    end
  end
end
