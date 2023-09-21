class Asset < ApplicationRecord
  has_many_attached :files
end
