class User < ApplicationRecord
  has_secure_password
  has_many :assets
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,message: "must be a valid email"}
end
