module Nora
  class SecureToken < ApplicationRecord
    belongs_to :user, foreign_key: :nora_user_id, class_name: 'Nora::User'
  end
end
