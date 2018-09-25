# репо
require 'rails_helper'
require 'webmock/rspec'

describe Repo do
  before(:each) {mock_github}

  describe 'get' do
    it 'ok' do
      r = Repo.get('https://github.com/rails/rails')
      expect(r[0][:author]).to eq 'tenderlove'
      expect(r[0][:total]).to eq 4220
      expect(r[0][:place]).to eq 1

      expect(r[2][:author]).to eq 'jeremy'
      expect(r[2][:total]).to eq 3282
      expect(r[2][:place]).to eq 3
    end
    it('nil') {expect(Repo.get(nil)).to be nil}
    it('bad url') {expect(Repo.get('http://duletsky.ru')).to be nil}
  end
end

# имитация запросов к сервису курсов
def mock_github
  # stub_request(:get, Rails.configuration.rate_url).
  # todo - вынести в конфиг
  body = '[' \
      '{"total": 3282, "author": {"login": "jeremy"}},' \
      '{"total": 3945, "author": {"login": "dhh"}},' \
      '{"total": 4220, "author": {"login": "tenderlove"}}' \
      ']'
  stub_request(:get, 'https://api.github.com/repos/rails/rails/stats/contributors').
      with(
          headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host' => 'api.github.com',
              'User-Agent' => 'Ruby'
          }).
      to_return(status: 200, body: body, headers: {})
end
