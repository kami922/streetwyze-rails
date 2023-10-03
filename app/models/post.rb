# frozen_string_literal: true

# post model is refereing to asset
class Post < ApplicationRecord
  has_many_attached :files
  belongs_to :user
  has_many :stories
  scope :ordered_by_title, -> { reorder(title: :asc) }
end
