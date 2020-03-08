class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    @links = Link.all.page(params[:page]).per(6)
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.user = current_user
    @link.save
      redirect_to links_path
  end

  def edit
    @link = current_user.links.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])

    if @link.user == current_user
      @link.update(link_params)
    else
    end

    redirect_to links_path
  end

  def destroy
    @link = Link.find(params[:id])

    if @link.user == current_user
      binding.pry
      @link.tag_list.remove()
      @link.destroy
    else
    end

    redirect_to links_path
  end

  def tagged
    if params[:tag].present?
      @links = Link.tagged_with(params[:tag])
    else
      @links = Link.all
    end

    render "links/index"
  end

  private

  def link_params
    params.require(:link).permit(:link, :link_descrition, :tag_list)
  end
end
