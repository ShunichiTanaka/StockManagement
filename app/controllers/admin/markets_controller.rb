class Admin::MarketsController < ApplicationController
  before_action :store_market, only: [:create]
  before_action :fetch_market, only: [:show, :edit, :update]

  def new
    @market = Market.new
  end

  def create
    @market = Market.new(store_market)
    if @market.save
      # TODO: error detail
      flash[:notice] = ["create new market"]
      return render "sample/index"
    else
      flash[:alert] = @market.errors.full_messages
      return redirect_to action: :new
    end
  end

  def index
    @markets = Market.page(params[:page]).per(10).order("created_at DESC")
  end

  def edit
  end

  def update
    if @market.update(store_market)
      # TODO: error detail
      flash[:notice] = ["update market"]
      redirect_to action: :index
    else
      flash[:alert] = @market.errors.full_messages
      render "edit"
    end
  end

  private

  def store_market
    params.require(:market).permit(:name, :info)
  end

  def fetch_market
    @market = Market.find_by(id: params[:id])
  end
end
