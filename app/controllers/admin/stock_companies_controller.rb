class Admin::StockCompaniesController < ApplicationController
	before_action :set_stock_company, only: [:create]
	before_action :get_stock_company, only: [:show, :edit, :update]

	def new
		@stock_company = StockCompany.new
	end

	def create
		@stock_company = StockCompany.new(set_stock_company)
		if @stock_company.save
			# TODO error detail
			flash[:notice] = 'create new stock company'
		  return render 'sample/index'
	  else
			# TODO error detail
			flash[:alert] = @stock_company.errors.messages.values
		  return redirect_to action: :new
		end
	end

	def index
		@stock_companies = StockCompany.page(params[:page]).per(10).order("created_at DESC")
	end

	def edit
	end

	def update
	 	if @stock_company.update(set_stock_company)
			# TODO error detail
		  flash[:notice] = 'update stock company'
		  redirect_to action: :index
	  else
			# TODO error detail
			flash[:alert] = 'nononononon'
		  render 'edit'
	  end
	end

	private

	def set_stock_company
		params.require(:stock_company).permit(:name, :info)
	end

	def get_stock_company
		@stock_company = StockCompany.find_by_id(params[:id])
	end
end
