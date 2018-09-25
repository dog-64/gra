require 'rails_helper'

RSpec.describe 'Index', type: :request do
  describe 'GET /' do
    it 'ok' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
