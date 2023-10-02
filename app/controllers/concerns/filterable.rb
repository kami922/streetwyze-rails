# frozen_string_literal: true

# module to handle filter tasks
module Filterable
  extend ActiveSupport::Concern

  included do
    before_action :filter_resources, only: [:filter]

    private

    def filter_resources
      filter_params = extract_filter_params(params)
      @filtered_posts = filter_posts(filter_params)
      respond_to do |format|
        format.html { render partial: 'filtered_posts' }
        format.js
      end
    end

    def extract_filter_params(params)
      {
        place_name: params[:place_name],
        address: params[:address],
        stuff: params[:stuff],
        category: params[:category],
        rating: params[:rating],
        description: params[:description]
      }
    end
  end
end
