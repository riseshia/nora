class Nora::User < ApplicationRecord
  has_one :secure_user_token

  def self.sign_in!(auth)
    find_or_initialize_by(provider: auth[:provider], uid: auth[:uid]).tap do |user|
      if user.persisted?
        user.secure_user_token.update!(token: auth[:credentials][:token])
      else
        user.assign_attributes(name: auth[:info][:name])
        user.build_secure_user_token(token: auth[:credentials][:token])
        user.save!
      end
    end
  end
end
