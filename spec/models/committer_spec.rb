require 'rails_helper'
require 'webmock/rspec'

URL = 'https://github.com/rails/rails'

describe Committer, type: :model do
  before(:each) { mock_github }

  it 'фабрика valid' do
    expect(FactoryBot.build(:committer)).to be_valid
  end

  it 'фабрика create' do
    expect(FactoryBot.create(:committer)).not_to be nil
  end

  describe 'zap' do
    it ('ok') do
      cmtr = FactoryBot.create(:committer)
      r = Committer.pdf(cmtr.id)
      expect(r).not_to be nil
      expect(File.file?(r)).to be true
      expect(Committer.zap).not_to be nil
      expect(File.file?(r)).to be false
    end
  end

  describe 'to_zip' do
    it ('nil') { expect(Committer.to_zip(nil, {})).to be nil }
    it ('string') { expect(Committer.to_zip('xxx', {})).to be nil }
    it ('not exist') { expect(Committer.to_zip(uniqp, {})).to be nil }
    it ('ok') do
      cmtr = FactoryBot.create(:committer)
      r = Committer.to_zip(Committer.where(id: cmtr.id), { id: cmtr.id })
      expect(r).not_to be nil
      expect(File.file?(r)).to be true
    end
  end

  describe 'pdf' do
    it ('nil') { expect(Committer.pdf(nil)).to be nil }
    it ('string') { expect(Committer.pdf('xxx')).to be nil }
    it ('not exist') { expect(Committer.pdf(uniqp)).to be nil }
    it ('ok') do
      cmtr = FactoryBot.create(:committer)
      r = Committer.pdf(cmtr.id)
      expect(r).not_to be nil
      expect(File.file?(r)).to be true
    end
  end

  describe 'create_by_url' do
    it 'ok' do
      expect(Committer.create_by_url(URL)).not_to be nil
      expect(Committer.count).to eq 3
      r = Committer.first
      # значения определены в mock_github
      expect(r.author).to eq 'tenderlove'
      expect(r.place).to eq 1
      expect(r.total).to eq 4220
    end
    it('nil') { expect(Committer.create_by_url(nil)).to eq "пустой url" }
    it('empty') { expect(Committer.create_by_url('')).to eq "пустой url" }
  end
end
