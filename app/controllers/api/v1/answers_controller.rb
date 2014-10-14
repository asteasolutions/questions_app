class Api::V1::AnswersController < AnswersController
  include ExeptionHandler

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
end
