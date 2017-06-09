class Admin::TradingHistoriesController < ApplicationController
  before_action :set_trading_history, only: [:create]
  before_action :get_trading_history, only: [:show, :edit, :update]

  def new
    @trading_history = TradingHistory.new
    @trading_history.purchase_date = Date.current
  end

  def create
    @trading_history = TradingHistory.new(set_trading_history)
    if @trading_history.save
      # TODO: error detail
      flash[:notice] = ["create new trading_history"]
      redirect_to action: "index"
    else
      flash[:alert] = @trading_history.errors.full_messages
      return redirect_to action: :new
    end
  end

  def index
    @trading_histories = TradingHistory.page(params[:page]).per(10).order("created_at DESC")
    @total_profit = TradingHistory.sum(:profit).to_s(:delimited)
    @current_month_profit = TradingHistory.current_month_profit
    @current_week_profit = TradingHistory.current_week_profit
  end

  def edit
  end

  def update
    if @trading_history.update(set_trading_history)
      # TODO: error detail
      flash[:notice] = ["update trading_history"]
      redirect_to action: "index"
    else
      flash[:alert] = @trading_history.errors.full_messages
      render "edit"
    end
  end

  private

  def set_trading_history
    trading_history = params.require(:trading_history).permit(
                        :purchase_date,
                        :code,
                        :purchase_price,
                        :stock_number,
                        :disposal_date,
                        :disposal_price,
                        :profit
                      )
    disposal_price = trading_history["disposal_price"]
    if disposal_price.present?
      profit = (disposal_price.to_i - trading_history["purchase_price"].to_i) * trading_history["stock_number"].to_i
      trading_history["profit"] = profit
    end
    trading_history
  end

  def get_trading_history
    @trading_history = TradingHistory.find_by(id: params[:id])
  end
end
