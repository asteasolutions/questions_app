class QuestionsController < ApplicationController
  before_action :set_question, only: [:show]

  def index
    @questions = Question.all
  end

  def create
    @question = Question.new question_params

    if @question.save
      render :show, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end

  end

  def show
  end

  private
    def set_question
      @question = Question.find params[:id]
    end

    def question_params
      params.require(:question).permit(:text, :user_id)
    end
end
