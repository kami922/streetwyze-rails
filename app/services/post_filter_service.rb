# frozen_string_literal: true

# post filter service for filter moduel
class PostsFilterService
  def initialize(params)
    @params = params
  end

  def filter_posts
    filtered_posts = apply_filters(Post.all)
    filter_params.compact.each do |key, value|
      filtered_posts = filtered_posts.where(key => value)
    end
    filtered_posts
  end

  def apply_filters(posts)
    posts = apply_place_name_filter(posts)
    posts = apply_address_filter(posts)
    posts = apply_stuff_filter(posts)
    posts = apply_category_filter(posts)
    posts = apply_rating_filter(posts)
    apply_description_filter(posts)
  end

  def apply_place_name_filter(posts)
    return posts unless filter_params[:place_name].present?

    posts.where(place_name: filter_params[:place_name])
  end

  def filter_params
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
