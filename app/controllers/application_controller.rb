class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private

  def render_404
    render json: { error: I18n.t('page_not_found') }, status: 404
  end
end

