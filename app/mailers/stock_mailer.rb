class StockMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.stock_mailer.send_stock_data.subject
  #
  def send_stock_data(data)
    @data = data

    mail to: "", subject: Date.current
  end
end
