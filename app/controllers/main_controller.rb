class MainController < ApplicationController

  before_action :require_user_logged_in!, except: [:index, :show]
  def index
    @allAssets = Asset.all
    if  !Current.user.nil?
      flash[:notice] = "please check the survey"
      @asset = Asset.new
    end
  end

  def create
    @asset = Current.user.assets.build(asset_params)

    if @asset.save
      redirect_to root_path, notice: "created successfully"
    else
      puts @asset.errors.full_messages
      render :new, notice: "something went wrong"
    end
  end



  private
  def asset_params
    params.require(:asset).permit(:place_name, :address, :stuff, :category, :rating, :description, files: [], user_attributes: [:id] )
  end
end
