require 'rails_helper'

describe 'RxSS API', type: :request do
  let(:lat_lon) { '39;0036,-94;4634' }

  before(:each) do
    get "/pharmacy/#{lat_lon}"
  end

  context 'when the endpoint has the latitude and longitude properly formatted' do
    it 'returns the closest pharmacy and a status code of 200' do

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("name","address","miles")
    end
  end

  context 'when latitude and longitude are not separated by a comma' do
    let(:lat_lon) { '39;0036-94;4634' }
    let(:error) { 'coordinates must be digits with a %3B after the second digit, and separated with a comma' }

    it 'returns an error and a status of bad request' do
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)["error"]).to eq(error)
    end
  end

  context 'when latitude or longitude are missing semi colons' do
    let(:error) { 'Latitude and Longitude decimal must be replaced with %3B' }

    context 'when latitude does not have an semi colon' do
      let(:lat_lon) { '390036,-94;4634' }

      it 'returns an error and a status of bad request' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to eq(error)
      end
    end

    context 'when longitude does not have an semi colon' do
      let(:lat_lon) { '39;0036,-944634' }

      it 'should return an error with a status bad request' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to eq(error)
      end
    end
  end
end
