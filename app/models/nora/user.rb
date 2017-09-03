module Nora
  class User < ApplicationRecord
    has_one :secure_token, foreign_key: :nora_user_id

    delegate :token, to: :secure_token, allow_nil: true

    def self.sign_in!(auth)
      find_or_initialize_by(provider: auth[:provider], uid: auth[:uid]).tap do |user|
        if user.persisted?
          user.secure_token.update!(token: auth[:credentials][:token])
        else
          user.assign_attributes(name: auth[:info][:name])
          user.build_secure_token(token: auth[:credentials][:token])
          user.save!
        end
      end
    end

    private

    def client
      Octokit::Client.new(access_token: secure_token.token)
    end
  end
end
