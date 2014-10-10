# spec/models/answer_spec.rb
require 'rails_helper'

describe Answer do
  it "has a valid values" do
    expect( create(:answer) ).to be_valid
  end

  it "is invalid without a text" do
    expect( build(:answer, text: nil) ).to validate_presence_of :text
  end

  it "is invalid without a question" do
    expect( build(:answer, question: nil) ).to validate_presence_of :user
  end

  it "is invalid without a user" do
    expect( build(:answer, user: nil) ).to validate_presence_of :user
  end

end


