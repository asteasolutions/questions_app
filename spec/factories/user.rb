# spec/factories/user.rb
require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password '123456'
  end
end
