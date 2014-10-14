#/spec/controllers/questions_controller_spec.rb
require 'rails_helper'

describe Api::V1::AnswersController do
  render_views

  before(:each) do
    sign_in :user, create(:user)
  end

  describe "GET #index" do

    it "validate :index response fields" do
      question = create(:question)
      answer_1 = create(:answer, question: question)
      answer_2 = create(:answer, question: question)

      get :index, question_id: question.id, format: :json

      expect(response.status).to eq 200
      expect(response.body).to match_json_schema(:answers_schema)
      expect(response.body).to match answer_1.text
      expect(response.body).to match answer_2.text
    end

    it "renders empty array for question without answers" do
      question = create(:question)
      get :index, question_id: question.id, format: :json

      expect(response.status).to eq 200
      expect(response.body).to eq "[]"
    end

    it "returns eror 404 when rendering answers of non existing question" do
      get :index, question_id: 10, format: :json

      expect(response.status).to eq 404
    end
  end

  describe "GET #show" do

    it "validate :show response for existing answer" do
      answer = create(:answer)
      get :show, id: answer.id, question_id: answer.question.id, format: :json

      expect(response.status).to eq 200
      expect(response.body).to match_json_schema(:answer_schema)
    end

    it "returns eror 404 for not existing answer" do
      get :show, id: 10, question_id: 1, format: :json

      expect(response.status).to eq 404
    end
  end


  describe "POST #create" do
    context "with valid attributes" do
      it "renders the :show template" do
        answer = create(:answer)
        post :create, answer: {text: answer.text, user_id: answer.user.id}, question_id: answer.question.id, format: :json

        expect(response.status).to eq 201
        expect(response.body).to match_json_schema(:answer_schema)
      end
    end

    context "with invalid attributes" do
      it "renders error messages" do
        answer = create(:answer)
        post :create, answer: {text: answer.text}, question_id: answer.question.id, format: :json

        expect(response.status).to eq 422
        expect(response.body).to match "can't be blank"
      end
    end
  end

end
