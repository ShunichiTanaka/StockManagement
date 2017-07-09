class StockMailer < ApplicationMailer
  default from: "stock_analysis_test"

  def send_stock_data(data)
    @data = data

    mail to: "", subject: Date.current
  end

  def send_bollinger_data(data)
    @data = data

    mail to: "", subject: "#{Date.current}のボリンジャー２α"
  end
end
