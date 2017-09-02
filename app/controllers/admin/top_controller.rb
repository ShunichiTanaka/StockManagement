class Admin::TopController < ApplicationController
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

  def index_to_chart
    render json: StockIndex.summary(params[:index_name])
  end
end
