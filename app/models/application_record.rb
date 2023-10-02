# frozen_string_literal: true

# base class for all models to inherit from
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
