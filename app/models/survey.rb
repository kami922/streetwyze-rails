# frozen_string_literal: true

# contains fields like
# title,script
# published is boolean field
class Survey < ApplicationRecord
  has_many :questions

  accepts_nested_attributes_for :questions
end
