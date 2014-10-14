class Api::V1::QuestionsController < QuestionsController
  include ExeptionHandler

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
end
