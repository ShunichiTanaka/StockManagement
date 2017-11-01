class Admin::BrandsController < ApplicationController
  before_action :store_brand, only: [:create]
  before_action :fetch_brand, only: [:show, :edit, :update]

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(store_brand)
    if @brand.save
      # TODO: error detail
      flash[:notice] = ["create new brand"]
      return render "sample/index"
    else
      flash[:alert] = @brand.errors.full_messages
      return redirect_to action: :new
    end
  end

  def index
    @brands = Brand.page(params[:page]).per(10)
  end

  def show
    @stock_price = StockPrice.where(code: params[:code])
                             .order("target_date")
                             .last
    yesterday_stock_price = StockPrice.where(code: params[:code])
                                      .order("target_date DESC")
                                      .offset(1)
                                      .limit(1)
                                      .first
    @stock_price.ratio = @stock_price.close - yesterday_stock_price.close
    @trading_histories = TradingHistory.where(code: params[:code])
  end

  def edit
  end

  def update
    if @brand.update(store_brand)
      # TODO: error detail
      flash[:notice] = ["update brand"]
      redirect_to action: :index
    else
      flash[:alert] = @brand.errors.full_messages
      render "edit"
    end
  end

  def destroy
    checked_items = params[:checked_item].keys
    Brand.delete(checked_items)
    # TODO: message
    flash[:notice] = ["delete brand"]
    redirect_to action: :index
  end

  def stock_price_to_chart
    render json: StockPrice.summary_brand(params[:code])
  end

  private

  def store_brand
    params.require(:brand).permit(:name, :code, :field_id, :market_id, :info)
  end

  def fetch_brand
    @brand = Brand.find_by(code: params[:code])
  end
end
