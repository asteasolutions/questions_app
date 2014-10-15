module ExeptionHandler

  def self.included(base)
    base.rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  end

  def render_404
    render nothing: true, :status => 404
  end
end
