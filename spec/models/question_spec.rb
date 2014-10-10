# spec/models/question_spec.rb
require 'rails_helper'

describe Question do
  it "has a valid values" do
    expect( create(:question) ).to be_valid
  end

  it "is invalid without a text" do
    expect( build(:question, text: nil) ).to validate_presence_of :text
  end

  it "is invalid without a user" do
    expect( build(:question, user: nil) ).to validate_presence_of :user
  end

end


