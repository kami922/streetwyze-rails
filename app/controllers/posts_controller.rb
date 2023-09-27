class PostsController < ApplicationController
  before_action :authenticate_user!, except:[ :index ]

  def index
    @asset_filter = Post.all
    @asset_filter = @asset_filter.where(place_name: @asset_filter&.first&.place_name,address: @asset_filter&.first&.address,stuff: @asset_filter&.first&.stuff,category: @asset_filter&.first&.category,rating: @asset_filter&.first&.rating,description: @asset_filter&.first&.description)
    @allAssets = Post.all
    @asset = Post.new
    if current_user
      flash[:notice] = "please check the survey"
    end
  end

  def create
    puts params
    @asset = current_user.posts.build(post_params)
    if @asset.save
      redirect_to root_path, notice: "created successfully"
    else
      puts @asset.errors.full_messages
      render :new, notice: "something went wrong"
    end
  end

  def edit
    @asset = Post.find_by(params[:id])
    # authorize @asset
    puts "asset: " + (@asset.user.id).to_s
    puts "current user: " + (Current.user.id).to_s
    if @asset.user.id != Current.user.id
      flash[:notice] = "You are not authorized to edit this asset."
      # redirect_to assets_path
      puts "from assets edit function"
    else
      puts "else path"
    end
  end

  def update
    @asset = Post.find(params[:id])
    if @asset.user == Current.user
      if @asset.update(asset_params)
        redirect_to @asset, notice: "Asset updated successfully."
      else
        render :edit
      end
    else
      flash[:alert] = "You are not authorized to edit this asset."
      redirect_to assets_path
    end
  end

  def destroy
    @asset = Post.find(params[:id])
    authorize @asset
    if @asset.user == current_user
      @asset.destroy
      redirect_to root_path, notice: "Asset deleted successfully."
    else
      flash[:alert] = "You are not authorized to delete this asset."
      redirect_to root_path
    end
  end

  def filter
    # Retrieve and filter posts based on filter criteria
    @filtered_posts = Post.where(
      place_name: params[:place_name],
      address: params[:address],
      stuff: params[:stuff],
      category: params[:category],
      rating: params[:rating],
      description: params[:description]
    )

    respond_to do |format|
      format.html { render partial: 'filtered_posts' } # Render the partial view
      format.js # Render JavaScript response (JSON)
    end
  end


  private
  def asset_params
    params.require(:post).permit(:place_name, :address, :stuff, :category, :rating, :description, files: [])
  end

  def post_params
    params.require(:post).permit(:place_name, :address, :stuff, :category, :rating, :description, files: [], user_attributes: [:id] )
    # params.permit(:place_name, :address, :stuff, :category, :rating, :description, files: [], user_attributes: [:id] )
  end
end
