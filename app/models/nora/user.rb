class Nora::User < ApplicationRecord
  has_one :secure_user_token
end
