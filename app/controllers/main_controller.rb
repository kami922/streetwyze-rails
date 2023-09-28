class MainController < ApplicationController
  before_action :require_user_logged_in!, except: %i[index show]
  def index
    @asset_filter = Post.all
    @asset_filter = @asset_filter.where(place_name: @asset_filter.first.place_name, address: @asset_filter.first.address,
                                        stuff: @asset_filter.first.stuff, category: @asset_filter.first.category, rating: @asset_filter.first.rating, description: @asset_filter.first.description)
    @allAssets = Post.all
    return if Current.user.nil?

    flash[:notice] = 'please check the survey'
    @asset = Post.new
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

  # def post_params
  #   params.require(:post).permit(:place_name, :address, :stuff, :category, :rating, :description, files: [], user_attributes: [:id] )
  # end
  def post_params
    params.permit(:place_name, :address, :stuff, :category, :rating, :description, files: [], user_attributes: [:id])
  end
end
