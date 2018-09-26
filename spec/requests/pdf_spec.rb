require 'rails_helper'

RSpec.describe 'Pdf', type: :request do
  describe 'show' do
    it 'not exist' do
      get pdf_path(0)
      expect(response).to have_http_status(302)
    end
    it 'ok' do
      cmtr = FactoryBot.create(:committer)
      get pdf_path(cmtr.id)
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'application/pdf'
    end
  end
end
