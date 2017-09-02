module Nora
  class SecureToken < ApplicationRecord
    belongs_to :user
  end
end
