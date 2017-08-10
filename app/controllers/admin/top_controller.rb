class Admin::TopController < ApplicationController
  before_action :display_chart, only: [:index]

  def index
    @current_stocks = StockPrice.where(target_date: StockPrice.from_current_day(1))
                                .order("trading_value DESC")
                                .limit(40)
    @previous_soaring = StockPrice.where(target_date: StockPrice.from_current_day(1))
                                  .where("previous_price_ratio IS NOT NULL")
                                  .order("previous_price_ratio DESC")
                                  .limit(40)
    @previous_droping = StockPrice.where(target_date: StockPrice.from_current_day(1))
                                  .where("previous_price_ratio IS NOT NULL")
                                  .order(:previous_price_ratio)
                                  .limit(40)
    indices = StockIndex.where(target_date: StockIndex.from_current_day(2))
    @previous_nikkei_ratio = indices[1].nikkei - indices[0].nikkei
    @previous_mothers_ratio = indices[1].mothers - indices[0].mothers
    @previous_jasdaq_ratio = indices[1].jasdaq - indices[0].jasdaq
  end

  def display_chart
    quand = Quandls.new
    quand.quandl_client
    # nikkei_data, jasdaq_data = quand.receive_info
    google_chart_nikkei = GoogleChart.new
    # @nikkei_average = google_chart_nikkei.line_chart(nikkei_data.reverse, false)
    google_chart_jasdaq = GoogleChart.new
    # @jasdaq_average = google_chart_jasdaq.line_chart(jasdaq_data.reverse, true)
  end

  def index_to_chart
    render json: StockIndex.summary(params[:index_name])
  end
end
