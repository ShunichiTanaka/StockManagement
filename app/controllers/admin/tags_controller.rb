class Admin::TagsController < ApplicationController
  before_action :store_tag, only: [:create]
  before_action :fetch_tag, only: [:show, :edit, :update]

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(store_tag)
    if @tag.save
      # TODO: error detail
      flash[:notice] = ["create new tag"]
      return redirect_to action: :index
    else
      flash[:alert] = @tag.errors.full_messages
      return redirect_to action: :new
    end
  end

  def index
    @tags = Tag.page(params[:page]).per(10).order("created_at DESC")
  end

  def edit
  end

  def update
    if @tag.update(store_tag)
      # TODO: error detail
      flash[:notice] = ["update tag"]
      redirect_to action: :index
    else
      flash[:alert] = @tag.errors.full_messages
      render "edit"
    end
  end

  private

  def store_tag
    params.require(:tag).permit(:name, :color,  :info)
  end

  def fetch_tag
    @tag = Tag.find_by(id: params[:id])
  end
end
