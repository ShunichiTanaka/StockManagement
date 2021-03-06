class Admin::StockCompaniesController < ApplicationController
  before_action :store_stock_company, only: [:create]
  before_action :fetch_stock_company, only: [:show, :edit, :update]

  def new
    @stock_company = StockCompany.new
  end

  def create
    @stock_company = StockCompany.new(store_stock_company)
    if @stock_company.save
      # TODO: error detail
      flash[:notice] = ["create new stock company"]
      return render "sample/index"
    else
      flash[:alert] = @stock_company.errors.full_messages
      return redirect_to action: :new
    end
  end

  def index
    @stock_companies = StockCompany.page(params[:page]).per(10).order("created_at DESC")
  end

  def edit
  end

  def update
    if @stock_company.update(store_stock_company)
      # TODO: error detail
      flash[:notice] = ["update stock company"]
      redirect_to action: :index
    else
      flash[:alert] = @stock_company.errors.full_messages
      render "edit"
    end
  end

  def destroy
    checked_items = params[:checked_item].keys
    StockCompany.delete(checked_items)
    # TODO: message
    flash[:notice] = ["delete stock company"]
    redirect_to action: :index
  end

  private

  def store_stock_company
    params.require(:stock_company).permit(:name, :info)
  end

  def fetch_stock_company
    @stock_company = StockCompany.find_by(id: params[:id])
  end
end
