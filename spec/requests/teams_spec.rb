require 'rails_helper'

RSpec.describe "Teams", type: :request do
  let(:user){ create(:user) }

  describe "GET /index" do
    it 'redirects to sign in on unauthorized access' do
      get teams_path
      expect(response).to have_http_status(:found)
    end

    context 'when user logged in' do
      before(:each) do
        allow(Current).to receive(:user).and_return(user)
      end

      it 'fetch all teams created by logged in user' do
        expect(user).to receive(:teams).once.and_return([])
        get teams_path
      end
    end
  end

  describe 'GET /new' do
    it 'redirects to sign in on unauthorized access' do
      get new_team_path
      expect(response).to have_http_status(:found)
    end

    context 'when user logged in' do
      before(:each) do
        allow(Current).to receive(:user).and_return(user)
      end

      it 'creates a new team' do
        expect(Team).to receive(:new)
        get  new_team_path
      end
    end
  end

  describe 'POST /' do
    it 'redirects to sign in on unauthorized access' do
      get teams_path
      expect(response).to have_http_status(:found)
    end

    context 'when user logged in' do
      before(:each) do
        allow(Current).to receive(:user).and_return(user)
      end

      it 'creates a new team' do
        expect(Team).to receive(:new)
        post teams_path
      end
    end
  end
end
