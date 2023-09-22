class AssetsController < ApplicationController

  # def index
  # end


  def edit
    @asset = Asset.find_by(params[:id])
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
    @asset = Asset.find(params[:id])
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
    @asset = Asset.find(params[:id])
    if @asset.user == Current.user
      @asset.destroy
      redirect_to assets_path, notice: "Asset deleted successfully."
    else
      flash[:alert] = "You are not authorized to delete this asset."
      redirect_to assets_path
    end
  end


  private
  def asset_params
    params.require(:asset).permit(:place_name, :address, :stuff, :category, :rating, :description, files: [])
  end

end
