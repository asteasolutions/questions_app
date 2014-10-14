module ExeptionHandler
  def render_404
    render nothing: true, :status => 404
  end
end
