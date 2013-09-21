class ApiController < ApplicationController
  before_filter :set_access_control_headers
  def random
    query = Kid.near([location.latitude, location.longitude], 500)
    query = query.where("age > 0")
    query = query.where("id != ?", params[:exclude]) if params[:exclude]
    @kid = query.to_a.sample
    render json: @kid
  end

  def index
  end

  def show
  end

  private

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end
