class Question < ApplicationRecord

  belongs_to :survey
  has_one_attached :image


end
