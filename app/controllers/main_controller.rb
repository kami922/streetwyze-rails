# frozen_string_literal: true

# First show all assets and stories then filter
class MainController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  include Authorizeable
  include FlashMessages
  include Indexfilter

  def index
    @all_assets = fetch_assets_or_stories(params[:type])
    @all_assets = apply_filters(@all_assets)
    @asset = Post.new
    @story = Story.new
    set_index_flash_notice
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

  def fetch_assets_or_stories(type)
    assets = Post.all
    stories = Story.all

    case type
    when 'assets'
      assets
    when 'stories'
      stories
    else
      assets
    end
  end
end
