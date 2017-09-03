require 'rails_helper'

RSpec.describe Nora::User, type: :model do
  describe '#sign_in!' do
    context 'with provider:github' do
      let(:auth) do
        {
          provider: 'github',
          uid: 'some-uid',
          credentials: { token: token },
          info: { name: 'alice' }
        }
      end

      subject(:user_token) { described_class.sign_in!(auth).reload.token }

      context 'with newbie' do
        let(:token) { 'some token' }
        it { expect(user_token).to eq(token) }
      end

      context 'with oldbie' do
        let(:user) do
          described_class.create!(provider: 'github', uid: 'uid', name: 'alice')
        end
        let(:token) { 'second token' }

        before { user.create_secure_token(token: 'some token') }
        it { expect(user_token).to eq(token) }
      end
    end
  end
end
