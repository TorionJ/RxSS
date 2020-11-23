require 'rails_helper'

describe 'RxSS API', type: :request do
  let(:lat) { '39;0036' }
  let(:lon) { '-94;4634' }

  before(:each) do
    get "/pharmacy/#{lat}/#{lon}"
  end

  context 'when the endpoint has the latitude and longitude properly formatted' do
    it 'returns the closest pharmacy and a status code of 200' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("name","address","miles")
    end
  end

  context 'when latitude or longitude are missing semi colons' do
    let(:error) { 'Latitude and Longitude decimal must be replaced with %3B' }

    context 'when latitude does not have a semi colon' do
      let(:lat) { '390036' }
      let(:lon) { '-94;4634' }

      it 'returns an error and a status code of 400' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to eq(error)
      end
    end

    context 'when longitude does not have a semi colon' do
      let(:lat) { '39;0036' }
      let(:lon) { '-944634' }

      it 'returns an error and a status code of 400' do
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to eq(error)
      end
    end
  end
end
