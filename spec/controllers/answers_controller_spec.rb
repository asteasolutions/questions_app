#/spec/controllers/questions_controller_spec.rb
require 'rails_helper'

describe AnswersController do

  before(:each) do
    sign_in :user, create(:user)
  end

  describe "GET #index" do
    it "populates an array of answers" do
      answer = create(:answer)
      get :index, question_id: answer.question.id, format: :json
      expect( assigns(:answers) ).to eq([answer])
    end

    it "renders the :index view" do
      answer = create(:answer)
      get :index, question_id: answer.question.id, format: :json
      expect( response ).to render_template :index
    end

    it "populates empty array for question without answers" do
      question = create(:question)
      get :index, question_id: question.id, format: :json
      expect( assigns(:answers) ).to eq([])
    end

    it "renders the :index view for question without answers" do
      question = create(:question)
      get :index, question_id: question.id, format: :json
      expect( response ).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested answer to @answer" do
      answer = create(:answer)
      get :show, id: answer.id, question_id: answer.question.id, format: :json
      expect( assigns(:answer) ).to eq(answer)
    end

    it "renders the :show template" do
      answer = create(:answer)
      get :show, id: answer.id, question_id: answer.question.id, format: :json
      expect( response ).to render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database" do
        answer = create(:answer)
        expect{post :create, answer: {text: answer.text, user_id: answer.user.id}, question_id: answer.question.id, format: :json}
        .to change(Answer, :count).by(1)
      end

      it "renders the :show template" do
        answer = create(:answer)
        post :create, answer: {text: answer.text, user_id: answer.user.id}, question_id: answer.question.id, format: :json
        expect( response ).to render_template :show
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        answer = create(:answer)
        expect{post :create, answer: {text: answer.text}, question_id: answer.question.id, format: :json}
        .to_not change(Answer, :count)
      end

      it "renders error messages" do
        answer = create(:answer)
        post :create, answer: {text: answer.text}, question_id: answer.question.id, format: :json
        expect( response.status ).to eq 422
      end
    end
  end

end
