# spec/factories/answer.rb
require 'faker'

FactoryGirl.define do
  factory :answer do |f|
    f.text { Faker::Lorem.paragraph }
    question {FactoryGirl.create(:question)}
    user {FactoryGirl.create(:user)}
  end
end
