class Admin::BrandsController < ApplicationController
  before_action :set_brand, only: [:create]
  before_action :get_brand, only: [:show, :edit, :update]

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(set_brand)
    if @brand.save
      # TODO error detail
      flash[:notice] = ["create new brand"]
      return render 'sample/index'
    else
      flash[:alert] = @brand.errors.full_messages
      return redirect_to action: :new
    end
  end

  def index
    @brands = Brand.page(params[:page]).per(10)
  end

  def show
    #quandl = Quandls.new(@brand)
    #quandl.quandl_client
    #brand_data = quandl.receive_stock_info
    #google_chart = GoogleChart.new
    #@brand_chart = google_chart.line_chart(brand_data, true)
  end

  def edit
  end

  def update
    if @brand.update(set_brand)
      # TODO error detail
      flash[:notice] = ["update brand"]
      redirect_to action: :index
    else
      flash[:alert] = @brand.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    checked_items = params[:checked_item].keys
    Brand.delete(checked_items)
    # TODO message
    flash[:notice] = ["delete brand"]
    redirect_to action: :index
  end

  private

  def set_brand
    params.require(:brand).permit(:name, :code, :field_id, :market_id, :info)
  end

  def get_brand
    @brand = Brand.find_by(code: params[:code])
  end
end
