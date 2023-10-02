# frozen_string_literal: true

# Old authentication logic we are making user a global variable to access it everywhere
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
