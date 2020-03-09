class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    @links = current_user.links.page(params[:page]).per(6)

    @user_tags = user_tags
  end

  def new
    @link = Link.new
    @user_tags = user_tags
  end

  def create
    @link = Link.new(link_params)
    @link.user = current_user

    if @link.save
      redirect_to links_path, notice: "Link successfully added"
    else
      render :new
    end
  end

  def edit
    @link = current_user.links.find(params[:id])
    @user_tags = user_tags
  end

  def update
    @link = Link.find(params[:id])

    if @link.user == current_user
      if @link.update(link_params)
        redirect_to links_path, notice: "Link successfully updated"
      else
        render :edit
      end
    else
      redirect_to links_path
    end
  end

  def destroy
    @link = current_user.links.find(params[:id])

    if @link.user == current_user && @link.destroy
      redirect_to links_path, alert: "Link successfully deleted"
    else
      render :edit
    end
  end

  def tagged
    @user_tags = user_tags

    if params[:tag].present?
      @links = current_user.links.tagged_with(params[:tag]).page(params[:page]).per(6)
      @tag = params[:tag]
    else
      @links = current_user.links.page(params[:page]).per(6)
    end

    render "links/index"
  end

  private

  def link_params
    params.require(:link).permit(:link, :link_descrition, :tag_list)
  end

  def user_tags
    ActiveRecord::Base.connection.execute(
      "SELECT * FROM tags "\
      "inner join taggings "\
      "on tags.id = taggings.tag_id "\
      "inner join links on taggings.taggable_id = links.id "\
      "where links.user_id = #{current_user.id}"
    )
  end
end
