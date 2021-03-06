# репо
require 'rails_helper'
require 'webmock/rspec'

describe Repo do
  # noinspection RubyBlockToMethodReference
  before(:each) { mock_github }

  describe 'err?' do
    it('true') { expect(Repo.err?('123')).to be true }
    it('false 4 hash') { expect(Repo.err?(x: 123)).to be false }
    it('false 4 array') { expect(Repo.err?([123])).to be false }
  end

  describe 'url_4api' do
    it 'awesome-elixir' do
      expect(Repo.url_4api('https://github.com/h4cc/awesome-elixir')).not_to be nil
    end
    it 'elixir' do
      expect(Repo.url_4api('https://github.com/elixir-lang/elixir')).not_to be nil
    end
    it 'rails' do
      expect(Repo.url_4api('https://github.com/rails/rails')).not_to be nil
    end
  end
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
    it('nil') { expect(Repo.get(nil)).to eq 'пустой url' }
    it('bad url') { expect(Repo.get('http://duletsky.ru')).to eq 'ошибка формата url' }
  end
end
