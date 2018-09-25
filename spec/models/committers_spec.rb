require 'rails_helper'

describe Committer, type: :model do
  # describe Committers do
  it 'фабрика valid' do
    FactoryBot.build(:committer).should be_valid()
  end

  it 'фабрика create' do
    FactoryBot.create(:committer).should_not be(nil)
  end

end
