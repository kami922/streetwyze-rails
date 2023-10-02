# frozen_string_literal: true

# module for add_index_filter
module Indexfilter
  extend ActiveSupport::Concern
  included do
    def index_filter_assets(first_asset)
      return Post.all unless first_asset

      Post.where(
        place_name: first_asset.place_name,
        address: first_asset.address,
        stuff: first_asset.stuff,
        category: first_asset.category,
        rating: first_asset.rating,
        description: first_asset.description
      )
    end
  end
end
