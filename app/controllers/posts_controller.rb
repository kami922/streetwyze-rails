# frozen_string_literal: true

# Controller responsible for handling posts-related actions, including filtering,
# creation, editing, and deletion of posts.
class PostsController < ApplicationController
  # before_action :authenticate_user!, except: [:index]
  include Filterable
  include Authorizeable
  include FlashMessages
  include Indexfilter

  def index
    @asset_filter = index_filter_assets(Post.first)
    @all_assets = Post.all
    @asset = Post.new
    set_index_flash_notice
  end

  def create
    puts params
    @asset = current_user.posts.build(post_params)
    if @asset.save
      redirect_to root_path, notice: 'created successfully'
    else
      puts @asset.errors.full_messages
      render :new, notice: 'something went wrong'
    end
  end

  def edit
    @asset = Post.find(params[:id])
    authorize @asset
    if @asset.present?
      render :edit
    else
      flash[:alert] = 'Asset not found.'
      redirect_to root_path
    end
  end

  def update
    @asset = Post.find(params[:id])
    if authorized_to_edit_asset?
      if update_asset
        redirect_to @asset, notice: 'Asset updated successfully.'
      else
        render :edit
      end
    else
      unauthorized_edit_redirect
    end
  end

  def destroy
    @asset = Post.find(params[:id])
    authorize @asset
    if @asset.destroy
      redirect_to root_path, notice: 'Asset deleted successfully.'
    else
      flash[:alert] = 'Failed to delete the asset.'
      redirect_to root_path
    end
  end

  def filter
    filter_params = extract_filter_params(params)
    @filtered_posts = filter_posts(filter_params)
    respond_to do |format|
      format.html { render partial: 'filtered_posts' }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :place_name,
      :address,
      :stuff,
      :category,
      :rating,
      :description,
      files: [],
      user_attributes: [:id]
    )
  end

  def update_asset
    @asset.update(post_params)
  end
end
