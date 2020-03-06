class LinksController < ApplicationController

  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.create(link_params)
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    @link.update(link_params)
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
  end

  private

  def link_params
    params.require(:link).permit(:link, :link_descrition)
  end
end
