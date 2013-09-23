class ApiController < ApplicationController
  before_filter :set_access_control_headers
  def random
    if location.country_code == "US"
      @limit = params[:limit].blank? ? 500 : params[:limit].to_i
      @location_query = [location.latitude, location.longitude]
      @query = Kid.near(@location_query, @limit)
    else
      @query = Kid.all
    end
    @query = @query.where("id != ?", params[:exclude].to_i) if params[:exclude]
    @query = @query.order("RANDOM()").limit(1)
    @kid = @query.first
    job = Afterparty::BasicJob.new @kid, :increment
    Rails.configuration.queue << job
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
