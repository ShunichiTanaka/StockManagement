class Admin::MarketsController < ApplicationController
  before_action :set_market, only: [:create]
  before_action :get_market, only: [:show, :edit, :update]

  def new
    @market = Market.new
  end

  def create
    @market = Market.new(set_market)
    if @market.save
      # TODO: error detail
      flash[:notice] = ["create new market"]
      return render 'sample/index'
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
    if @market.update(set_market)
      # TODO: error detail
      flash[:notice] = ["update market"]
      redirect_to action: :index
    else
      flash[:alert] = @market.errors.full_messages
      render "edit"
    end
  end

  private

  def set_market
    params.require(:market).permit(:name, :info)
  end

  def get_market
    @market = Market.find_by(id: params[:id])
  end
end
