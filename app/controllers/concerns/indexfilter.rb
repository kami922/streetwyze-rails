# frozen_string_literal: true

# module for add_index_filter
module Indexfilter
  extend ActiveSupport::Concern
  include DateFilter

  included do
    def apply_filters(assets_or_stories)
      filtered_results = assets_or_stories
      filtered_results = filter_by_author(filtered_results)
      filtered_results = filter_by_date(filtered_results)
      filtered_results = filter_by_type(filtered_results)
      filtered_results = filter_by_rating(filtered_results)
      filtered_results = filter_by_category(filtered_results)
      filter_by_media(filtered_results)
    end

    private

    def filter_by_author(results)
      return results unless params[:filter_author].present?

      results.where(user_id: params[:filter_author])
    end

    def filter_by_date(results)
      return results unless params[:filter_date_range].present?

      results.where(created_at: filter_date_range)
    end

    def filter_by_type(results)
      return results unless params[:filter_type].present?

      results.where(stuff: params[:filter_type])
    end

    def filter_by_rating(results)
      return results unless params[:filter_rating].present?

      results.where(rating: params[:filter_rating])
    end

    def filter_by_category(results)
      return results unless params[:filter_category].present?

      results.where(category: params[:filter_category])
    end

    def filter_by_media(results)
      return results unless params[:filter_media].present?

      case params[:filter_media]
      when 'With Media'
        results.with_attached_files
      when 'Without Media'
        results.where.not(id: ActiveStorage::Attachment.select(:record_id).distinct)
      else
        results
      end
    end
  end
end
