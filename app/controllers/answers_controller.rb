class AnswersController < ApplicationController
  before_action :set_question, only: [:index]
  before_action :set_answer, only: [:show]

  def index
    @answers = @question.answers
  end

  def show
  end

  def create
    @answer = Answer.new answer_params

    if @answer.save
      render :show, status: :created
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  private

    def set_question
      @question = Question.find params[:question_id]
    end

    def set_answer
      @answer = Answer.find params[:id]
    end

    def answer_params
      res = params.require(:answer).permit(:text, :user_id)
      res[:question_id] = params[:question_id]
      res
    end
end
