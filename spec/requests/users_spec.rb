require 'rails_helper'

RSpec.describe "Users", type: :request do

  let!(:users) { FactoryGirl.create_list(:user, 10) }
  let(:user_id) { users.first.id }

  describe "GET /users" do

    before :each do
      @user ||= FactoryGirl.create(:user)
      @user.reset_authentication_token! unless @user.token
      @request.env['Authorization'] = 'Token token=' + @user.token
    end

    before { get '/users' }

    it "it returns 10 users" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET /users/:id' do

    before { get "/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

end
