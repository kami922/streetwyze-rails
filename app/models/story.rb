# frozen_string_literal: true

require 'csv'

# Story class
class Story < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.to_csv
    attributes = %w[id description rating place_name address stuff category created_at updated_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |story|
        csv << attributes.map { |attr| story.send(attr) }
      end
    end
  end
end
