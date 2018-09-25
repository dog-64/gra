# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :committer do
    repo { uniqid }
    user { uniqid }
    stock { uniqp }
    sequence(:place) { |n| n }
    sequence(:total) { |n| n }
  end
end
