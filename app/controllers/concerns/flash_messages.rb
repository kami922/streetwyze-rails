# frozen_string_literal: true

# module to handle flash messages
module FlashMessages
  extend ActiveSupport::Concern

  included do
    def set_index_flash_notice
      flash[:alert] = 'Please check the survey' if current_user.present?
    end
  end
end
