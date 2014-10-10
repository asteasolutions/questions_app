#/spec/controllers/questions_controller_spec.rb
require 'rails_helper'

describe QuestionsController do

  before(:each) do
    sign_in :user, create(:user)
  end

  describe "GET #index" do
    it "populates an array of questions" do
      question = create(:question)
      get :index, format: :json
      expect( assigns(:questions) ).to eq([question])
    end

    it "renders the :index view" do
      get :index, format: :json
      expect( response ).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested question to @question" do
      question = create(:question)
      get :show, id: question.id, format: :json
      expect( assigns(:question) ).to eq(question)
    end

    it "renders the :show template" do
      get :show, id: create(:question) , format: :json
      expect( response ).to render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database" do
        question = create(:question)
        expect{post :create, question: {text: question.text, user_id: question.user.id}, format: :json}
        .to change(Question, :count).by(1)
      end

      it "renders the :show template" do
        question = create(:question)
        post :create, question: {text: question.text, user_id: question.user.id}, format: :json
        expect( response ).to render_template :show
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect{ post :create, question: attributes_for(:invalid_question), format: :json }
        .to_not change(Question,:count)
      end

      it "renders error messages" do
        post :create, question: attributes_for(:invalid_question), format: :json
        expect( response.status ).to eq 422
      end
    end
  end
end
