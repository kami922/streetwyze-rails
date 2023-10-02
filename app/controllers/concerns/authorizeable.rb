# frozen_string_literal: true

# module to handle authentication tasks
module Authorizeable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, except: [:index]

    def authorized_to_edit_asset?
      @asset.user.id == current_user.id
    end

    def unauthorized_edit_redirect
      flash[:alert] = 'You are not authorized to edit this asset.'
      redirect_to assets_path
    end
  end
end
