class MainController < ApplicationController
  def index
    if  !Current.user.nil?
      flash[:notice] = "please check the survey"
      @asset = Asset.new
      @allAssets = Asset.all
    end
  end

  def create
    @asset = Asset.create(asset_params)

    if @asset.save
      redirect_to root_path, notice: "created successfully"
    else
      render :new , notice: "something went wrong"
    end
  end


  private
  def asset_params
    params.require(:asset).permit(:place_name, :address, :stuff, :category, :rating, :description, files: [])
  end
end
