require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it 'returns ok status' do
      get sessions_new_path
      expect(response).to have_http_status(:ok)
    end

    it 'redirects to teams page while session exists' do
      allow(Current).to receive(:user).and_return(build(:user))
      get sessions_new_path
      expect(response).to have_http_status(:found)
    end
  end

  describe 'POST /sessions' do
    let(:user){ double('user', id: 'some-id') }

    before(:each) do
      allow(User).to receive(:find_by).and_return(user)
    end

    it 'authenticate user with password' do
      expect(user).to receive(:authenticate).once.and_return(true)
      post sessions_path, params: { email: 'some-email', password: 'some-password' }
    end

    it 'redirects (:found) on valid authentication' do
      allow(user).to receive(:authenticate).once.and_return(true)
      post sessions_path, params: { email: 'some-email', password: 'some-password' }
      expect(response).to have_http_status(:found)
    end

    it 'returns error message on invalid authentication' do
      allow(user).to receive(:authenticate).once.and_return(false)
      post sessions_path, params: { email: 'some-email', password: 'some-password' }
      expect(response.body).to include('Invalid email/password combination')
    end
  end
end
