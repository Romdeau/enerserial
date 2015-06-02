module StocksHelper
  def check_job(stock)
    if stock.job != nil
      stock.job.job_number
    else
      ''
    end
  end

  def check_customer(stock)
    if stock.job != nil && stock.job.customer != nil && stock.job.customer.name != nil
      stock.job.customer.name
    else
      ''
    end
  end

  def format_serial(stock)
    if stock.serial_number == nil
      'TBA'
    else
      stock.serial_number
    end
  end

  def format_ppsr(stock)
    if (stock.ppsr == nil or stock.ppsr == '' ) and stock.needs_ppsr == true
      'Pending PPSR'
    elsif (stock.ppsr == nil or stock.ppsr == '' ) and stock.needs_ppsr == false
      'No PPSR Required'
    else
      "#{stock.ppsr}"
    end
  end
end
