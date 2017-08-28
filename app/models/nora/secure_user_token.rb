module Nora
  class Nora::SecureUserToken < ApplicationRecord
    self.table_name = 'nora_secure_user_tokens'
    belongs_to :user
  end
end
