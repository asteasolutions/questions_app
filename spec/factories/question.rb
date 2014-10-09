# spec/factories/question.rb
require 'faker'

FactoryGirl.define do
  factory :question do |f|
    f.text { Faker::Lorem.paragraph }
    user {FactoryGirl.create(:user)}
  end

  factory :invalid_question, parent: :question do |f|
    user nil
  end

end
