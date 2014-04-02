module StocksHelper
  def check_job(stock)
    if stock.job != nil
      stock.job.job_number
    else
      ''
    end
  end
end
