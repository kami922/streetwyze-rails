class Post < ApplicationRecord
  has_many_attached :files
  belongs_to :user
  scope :ordered_by_title, -> { reorder(title: :asc) }

end