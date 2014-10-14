#/spec/controllers/questions_controller_spec.rb
require 'rails_helper'


describe Api::V1::QuestionsController do
  render_views

  before(:each) do
    sign_in :user, create(:user)
  end

  describe "GET #index" do

    it "validate :index response fields" do
      question_1 = create(:question)
      question_2 = create(:question)

      get :index, format: :json

      expect(response.status).to eq 200
      expect(response.body).to match_json_schema(:questions_schema)
      expect(response.body).to match question_1.text
      expect(response.body).to match question_2.text
    end

    it "render empty array when there are no questions" do
      get :index, format: :json

      expect(response.status).to eq 200
      expect(response.body).to eq "[]"
    end

  end

  describe "GET #show" do
    it "validate :show response for existing question" do
      question = create(:question)
      get :show, id: question.id, format: :json

      expect(response.status).to eq 200
      expect(response.body).to match_json_schema(:question_schema)
    end

    it "returns eror 404 for not existing question" do
      get :show, id: 10, format: :json

      expect(response.status).to eq 404
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "renders the :show template" do
        question = create(:question)
        post :create, question: {text: question.text, user_id: question.user.id}, format: :json

        expect(response.status).to eq 201
        expect(response.body).to match_json_schema(:question_schema)
      end
    end

    context "with invalid attributes" do
      it "renders error messages" do
        post :create, question: attributes_for(:invalid_question), format: :json

        expect(response.status).to eq 422
        expect(response.body).to match "can't be blank"
      end
    end
  end
end
