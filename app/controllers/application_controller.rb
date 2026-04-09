class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes
  skip_forgery_protection if: -> { request.format.json? }

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.html { render file: Rails.root.join("public/404.html"), status: :not_found, layout: false }
      format.json { render json: { error: "Not found" }, status: :not_found }
    end
  end
end
