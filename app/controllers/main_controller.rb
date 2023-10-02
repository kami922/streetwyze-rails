# frozen_string_literal: true

# First show all assets and stories then filter
class MainController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  def index
    @asset_filter = index_filter_assets(Post.first)
    @all_assets = Post.all
    @asset = Post.new
    set_index_flash_notice
  end

  def create
    puts params
    @asset = Current.user.posts.build(post_params)
    if @asset.save
      redirect_to root_path, notice: 'created successfully'
    else
      puts @asset.errors.full_messages
      render :new, notice: 'something went wrong'
    end
  end

  private

  def post_params
    params.permit(
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

  def index_filter_assets(first_asset)
    return Post.all unless first_asset

    Post.where(
      place_name: first_asset.place_name,
      address: first_asset.address,
      stuff: first_asset.stuff,
      category: first_asset.category,
      rating: first_asset.rating,
      description: first_asset.description
    )
  end

  def set_index_flash_notice
    flash[:alert] = 'Please check the survey' if current_user.present?
  end
end
