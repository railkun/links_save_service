class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    @links = current_user.links.page(params[:page]).per(6)

    @user_tags = user_tags
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
    @user_tags = user_tags

    if params[:tag].present?
      @links = Link.tagged_with(params[:tag]).page(params[:page]).per(6)
      @tag = params[:tag]
    else
      @links = Link.all.page(params[:page]).per(6)
    end




    render "links/index"
  end

  private

  def link_params
    params.require(:link).permit(:link, :link_descrition, :tag_list)
  end

  def user_tags
    user_tags = ActiveRecord::Base.connection.execute(
      "SELECT * FROM tags "\
      "inner join taggings "\
      "on tags.id = taggings.tag_id "\
      "inner join links on taggings.taggable_id = links.id "\
      "where links.user_id = #{current_user.id}"
    )
  end
end
