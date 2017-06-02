class StockMailer < ApplicationMailer
  default from: "stock_analysis_test"

  def send_stock_data(data)
    @data = data

    mail to: "@gmail.com", subject: Date.current
  end
end
