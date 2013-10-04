class ApiController < ApplicationController
  before_filter :set_access_control_headers
  def random
    if location.country_code == "US"
      @limit = params[:limit].blank? ? 500 : params[:limit].to_i
      @query = Kid.near_location(location, @limit)
    else
      @query = Kid.all
    end
    @query = @query.excluding(params[:exclude]) if params[:exclude]
    @kid = @query.random
    @kid.increment!
    render json: @kid, meta: {location: location.data}
  end

  def index
    Kid.all.to_a
  end

  def show
  end

  private

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end
