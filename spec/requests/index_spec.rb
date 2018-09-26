require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Index', type: :feature do
  before(:each) { mock_github }

  describe 'GET /' do
    it 'ok' do
      visit root_path
      expect(page.status_code).to be(200)
    end
    it 'click' do
      visit url_path
      fill_in 'url', with: 'https://github.com/rails/rails'
      click_button
      expect(page.status_code).to be(200)
    end
    it 'show' do
      cmtr = FactoryBot.create(:committer)
      url = url_path(url: cmtr.repo)
      visit url
      expect(page.status_code).to be(200)
      expect(page.body).to include 'tenderlove'
    end
  end
end
