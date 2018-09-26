require 'rails_helper'

RSpec.describe 'Zip', type: :request do
  describe 'show' do
    it '0' do
      get zip_path(0)
      expect(response).to have_http_status(302)
    end
    it 'not exist' do
      get zip_path(uniqp)
      expect(response).to have_http_status(302)
    end
    it 'ok' do
      cmtr = FactoryBot.create(:committer)
      get zip_path(cmtr.stock)
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/zip'
    end
  end
end
