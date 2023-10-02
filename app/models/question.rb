# frozen_string_literal: true

# question model  has many relation with survey
class Question < ApplicationRecord
  belongs_to :survey
  has_one_attached :image
end
