# frozen_string_literal: true

# Story class
class Story < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
