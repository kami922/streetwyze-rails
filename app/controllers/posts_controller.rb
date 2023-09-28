# to remove rubo cop error
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @asset_filter = Post.all
    @asset_filter = @asset_filter.where(
      place_name: @asset_filter&.first&.place_name,
      address: @asset_filter&.first&.address,
      stuff: @asset_filter&.first&.stuff,
      category: @asset_filter&.first&.category,
      rating: @asset_filter&.first&.rating,
      description: @asset_filter&.first&.description
    )
    @all_assets = Post.all
    @asset = Post.new
    return unless current_user

    flash[:alert] = 'please check the survey'
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
    filter_params = {
      place_name: params[:place_name],
      address: params[:address],
      stuff: params[:stuff],
      category: params[:category],
      rating: params[:rating],
      description: params[:description]
    }
    @filtered_posts = filter_posts(filter_params)
    respond_to do |format|
      format.html { render partial: 'filtered_posts' }
      format.js
    end
  end

  private

  def asset_params
    params.require(:post).permit(:place_name, :address, :stuff, :category, :rating, :description, files: [])
  end

  def post_params
    params.require(:post).permit(:place_name, :address, :stuff, :category, :rating, :description, files: [],
                                                                                                  user_attributes: [:id])
  end

  def authorized_to_edit_asset?
    @asset.user.id == current_user.id
  end

  def update_asset
    @asset.update(asset_params)
  end

  def unauthorized_edit_redirect
    flash[:alert] = 'You are not authorized to edit this asset.'
    redirect_to assets_path
  end

  def filter_posts(filter_params)
    filtered_posts = Post.all

    filter_params.compact.each do |key, value|
      filtered_posts = filtered_posts.where(key => value)
    end

    filtered_posts
  end
end
