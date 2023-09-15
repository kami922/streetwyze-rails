class Survey < ApplicationRecord
  has_many :questions

  # has_many :questions, dependent: :destory
  accepts_nested_attributes_for :questions


end
