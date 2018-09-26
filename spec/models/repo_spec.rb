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
