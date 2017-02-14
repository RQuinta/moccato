require 'rails_helper'

RSpec.describe "Users", type: :request do

  let!(:users) { FactoryGirl.create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:admin) { FactoryGirl.create :admin }

  describe "GET /users" do

    before :each do
      get '/users', nil, :authorization => 'Token token=' + admin.token
    end

    it "it returns 10 users" do
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(11)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  describe 'GET /users/:id' do

    context 'when the record exists' do

      before :each do
        get '/users/1', nil, :authorization => 'Token token=' + admin.token
      end

      it 'returns the user' do
        json = JSON.parse(response.body)
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do

      before :each do
        get '/users/100', nil, :authorization => 'Token token=' + admin.token
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

end
