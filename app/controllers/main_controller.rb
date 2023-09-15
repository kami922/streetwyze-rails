class MainController < ApplicationController
  def index
    if  !Current.user.nil?
      flash[:notice] = "please check the survey"
    end

  end
end
