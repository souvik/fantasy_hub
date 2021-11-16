require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    it 'returns ok status' do
      get new_user_path
      expect(response).to have_http_status(:ok)
    end

    it 'creates a new user' do
      expect(User).to receive(:new).once
      get new_user_path
    end
  end

  describe 'POST /users' do
    let(:user_params){ { user: {
      first_name: 'some-name',
      last_name: 'some-name',
      email: 'some-email',
      password: 'some-password',
      password_confirmation: 'some-password'
    } } }
    let(:user){ double('some-user') }

    it 'creates a new user' do
      allow(user).to receive(:save!)
      expect(User).to receive(:new).once.and_return(user)
      post users_path, params: user_params
    end

    it 'saves the user' do
      allow(User).to receive(:new).and_return(user)
      expect(user).to receive(:save!)
      post users_path, params: user_params
    end

    it 'redirects (:found) on save the user' do
      post users_path, params: user_params
      expect(response).to have_http_status(:found)
    end

    it 'wont redirects on invalid user params' do
      post users_path, params: { user: user_params[:user].except(:first_name) }
      expect(response).not_to have_http_status(:found)
    end
  end
end
